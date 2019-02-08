# installRealSense2ROSTX
Install the Intel RealSense Camera package for ROS on the NVIDIA Jetson TX Development Kit
MIT License
Copyright (c) 2018-19 Jetsonhacks

The installLibRealSenseROS script will install librealsense and realsense_camera as ROS packages. These scripts have been tested with a RealSense D435 camera.

This is the third step of a three step process.

The first step requires a kernel modification. librealsense 2 requires a modified kernel which modularizes uvcvideo and adds the RealSense video modes to the uvcvideo driver.

The easiest way to accomplish this is to use the 'buildLibrealsense2TX' repository on the Github JetsonHacks account (https://github.com/jetsonhacks/buildLibrealsense2TX). There are scripts which download the kernel source, apply the necessary patches, make the kernel, and then copy the kernel images to the boot directory. There are also scripts to build the librealsense library itself, which is useful for testing purposes.

The second step is to install ROS on the Jetson TX. There are convenience scripts to help do this on the Github JetsonHacks account in the installROSTX2 repository (https://github.com/jetsonhacks/installROSTX2) or installROSTX1 repository (https://github.com/jetsonhacks/installROSTX1). Note that the repository installs ros-base, if other configurations such as ros-desktop are desired, the scripts can do that through the command line parameters.

This step, the third step, is to install librealsense and realsense as ROS packages. The script installRealSenseROS.sh in this directory will install librealsense and realsense and dependencies in a Catkin Workspace.

To install:

$ ./installRealSenseROS.sh \<catkin_ws_name\>

The script 'setupTX.sh' simply turns off the USB autosuspend setting on the Jetson TX so that the camera is always available. 

This installs RealSense ROS version 2.0. 

<h3>Releases:</h3>

<b>February, 2019<b>
* v1.1
* Add support for catkin build workspaces (Thanks to Johann Lange)

<b>June, 2018<b>
* v1.0
* Initial Release
