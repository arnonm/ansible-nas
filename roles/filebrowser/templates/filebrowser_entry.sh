#!/bin/sh

if [ -f /filebrowser_runonce.sh ] && [ ! -f /filebrowser_runonce.flag ]
then
    chmod +x /filebrowser_runonce.sh
    /filebrowser_runonce.sh
    touch /filebrowser_runonce.flag
fi

if [ -f /filebrowser_run.sh ]
then
    chmod +x /filebrowser_run.sh
    /filebrowser_run.sh
    
fi

/filebrowser