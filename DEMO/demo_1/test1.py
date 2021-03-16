#coding: utf8

import rospy
from clover import srv
from std_srvs.srv import Trigger
import math

rospy.init_node('flight')

get_telemetry = rospy.ServiceProxy('get_telemetry', srv.GetTelemetry)
navigate = rospy.ServiceProxy('navigate', srv.Navigate)
navigate_global = rospy.ServiceProxy('navigate_global', srv.NavigateGlobal)
set_position = rospy.ServiceProxy('set_position', srv.SetPosition)
set_velocity = rospy.ServiceProxy('set_velocity', srv.SetVelocity)
set_attitude = rospy.ServiceProxy('set_attitude', srv.SetAttitude)
set_rates = rospy.ServiceProxy('set_rates', srv.SetRates)
land = rospy.ServiceProxy('land', Trigger)

def navigate_wait(x=0, y=0, z=0, yaw=float('nan'), speed=0.5, frame_id='', auto_arm=False, tolerance=0.2):
    navigate(x=x, y=y, z=z, yaw=yaw, speed=speed, frame_id=frame_id, auto_arm=auto_arm)

    while not rospy.is_shutdown():
        telem = get_telemetry(frame_id='navigate_target')
        if math.sqrt(telem.x ** 2 + telem.y ** 2 + telem.z ** 2) < tolerance:
            break
        rospy.sleep(0.2)

def land_wait():
    land()
    while get_telemetry().armed:
        rospy.sleep(0.2)

def go_home():
    navigate_wait(x=0, y=0, z=1, frame_id='aruco_map', auto_arm=True, speed=10)

navigate_wait(x=0, y=0, z=2, frame_id='body', auto_arm=True, speed=5)
navigate(x=9, y=0, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(0.7)
navigate(x=9, y=9, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(1.85)
navigate(x=1, y=8, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(1.8)
navigate(x=0, y=7, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(1.8)
navigate(x=4, y=3, z= 0.3, frame_id='aruco_map', speed=10)
rospy.sleep(1.7)
navigate(x=9, y=0, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(2)
go_home()

land_wait()