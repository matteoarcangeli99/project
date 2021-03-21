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
    navigate_wait(x=0, y=0, z=1, frame_id='aruco_90', auto_arm=True, speed=20)

navigate_wait(x=0, y=0, z=2, frame_id='body', auto_arm=True, speed=5)
navigate_wait(x=0, y=0, z=2, frame_id='aruco_90', auto_arm=True, speed=5)
navigate(x=9, y=1, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(0.9)
navigate(x=9, y=6, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(0.7)
navigate(x=6, y=9, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(0.7)
navigate(x=0, y=7, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(0.7)
navigate(x=8, y=0, z=2, frame_id='aruco_map', speed=10)
rospy.sleep(2)
navigate(x=0, y=0, z=1.5, frame_id='aruco_map', speed=10)
rospy.sleep(1)
navigate_wait(x=0, y=9, z=2, frame_id='aruco_map', speed=10)
navigate_wait(x=0, y=0, z=1, frame_id='aruco_45', speed=10)
land()
rospy.sleep(3)

navigate_wait(x=0, y=0, z=1.5, frame_id='body', auto_arm=True, speed=5)
navigate_wait(x=0, y=0, z=1, frame_id='aruco_63', speed=8)
land()
rospy.sleep(3)

navigate_wait(x=0, y=0, z=1, frame_id='body', auto_arm=True)
go_home()
land()