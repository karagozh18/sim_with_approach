#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/halil/Documents/sim_ws/src/aruco_detect"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/halil/Documents/sim_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/halil/Documents/sim_ws/install/lib/python2.7/dist-packages:/home/halil/Documents/sim_ws/build/aruco_detect/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/halil/Documents/sim_ws/build/aruco_detect" \
    "/usr/bin/python2" \
    "/home/halil/Documents/sim_ws/src/aruco_detect/setup.py" \
     \
    build --build-base "/home/halil/Documents/sim_ws/build/aruco_detect" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/halil/Documents/sim_ws/install" --install-scripts="/home/halil/Documents/sim_ws/install/bin"
