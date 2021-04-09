from clover import srv
from std_srvs.srv import Trigger
import rospy
import math
from pyzbar import pyzbar
from cv_bridge import CvBridge
from sensor_msgs.msg import Image
from clover.srv import SetLEDEffect

bridge = CvBridge()

rospy.init_node('barcode_test')

get_telemetry = rospy.ServiceProxy('get_telemetry', srv.GetTelemetry)
navigate = rospy.ServiceProxy('navigate', srv.Navigate)
navigate_global = rospy.ServiceProxy('navigate_global', srv.NavigateGlobal)
set_position = rospy.ServiceProxy('set_position', srv.SetPosition)
set_velocity = rospy.ServiceProxy('set_velocity', srv.SetVelocity)
set_attitude = rospy.ServiceProxy('set_attitude', srv.SetAttitude)
set_rates = rospy.ServiceProxy('set_rates', srv.SetRates)
land = rospy.ServiceProxy('land', Trigger)
set_effect = rospy.ServiceProxy('led/set_effect', SetLEDEffect)  # define proxy to ROS-service

def navigate_wait(x=0, y=0, z=0, speed=0.5, frame_id='body', auto_arm=False):
    res = navigate(x=x, y=y, z=z, yaw=float('nan'), speed=speed, frame_id=frame_id, auto_arm=auto_arm)

    if not res.success:
        raise Exception(res.message)

    while not rospy.is_shutdown():
        telem = get_telemetry(frame_id='navigate_target')
        if math.sqrt(telem.x ** 2 + telem.y ** 2 + telem.z ** 2) < 0.2:
            return
        rospy.sleep(0.2)

PI_2 = math.pi / 2

def flip():
    start = get_telemetry()  # memorize starting position

    set_rates(thrust=1)  # bump up
    rospy.sleep(0.3)

    set_rates(pitch_rate=35, thrust=0.3)  # pitch flip

    while True:
        telem = get_telemetry()
        flipped = abs(telem.pitch) > PI_2 or abs(telem.roll) > PI_2
        if flipped:
            break

    rospy.loginfo('finish flip')
    set_position(x=start.x, y=start.y, z=start.z, yaw=start.yaw)  # finish flip

b_data = ''
# Image subscriber callback function
def image_callback(data):
    global b_data
    cv_image = bridge.imgmsg_to_cv2(data, 'bgr8')  # OpenCV image
    barcodes = pyzbar.decode(cv_image)
    for barcode in barcodes:
        b_data = barcode.data.encode("utf-8")

def col():
    qr = b_data.split()
    set_effect(r=int(qr[0]), g=int(qr[1]), b=int(qr[2]))
    rospy.sleep(5)

image_sub = rospy.Subscriber('main_camera/image_raw_throttled', Image, image_callback, queue_size=1)

navigate_wait(z=1, frame_id='body', auto_arm=True)
navigate_wait(x=1, y=2, z=1.5, frame_id='aruco_map', speed=1.5)
navigate_wait(x=1, y=1, z=0, frame_id='navigate_target', speed=1.5)
navigate_wait(x=1, y=-1, z=0, frame_id='navigate_target', speed=1.5)
navigate_wait(x=1, y=-2, z=0, frame_id='navigate_target', speed=1.5)
flip()
navigate_wait(x=-3, y=0, z=0, frame_id='navigate_target', speed=1.5)
col()
land()