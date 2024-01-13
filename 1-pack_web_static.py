#!/usr/bin/python3
"""Create funtion for generate tgz file."""
from fabric.api import local
import time


def do_pack():
    """Gerenate tgz."""
    timestamp = time.strftime("%Y%m%d%H%M%S")
    try:
        local("mkdir -p versions")
        local("tar -cvzf versions/web_static_{:s}.tgz web_static/".
              format(timestamp))
        return ("versions/web_static_{:s}.tgz".format(timestamp))
    except:
        return None
