# docker-ubu-avahi
Installs avahi-daemon into an Ubuntu Linux container

![avahi](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Avahi-logo.svg/84px-Avahi-logo.svg.png)

## Description

Avahi is a free zero-configuration networking (zeroconf) implementation, including a system for multicast DNS/DNS-SD service discovery


http://www.avahi.org/

## Usage

    docker create --name=avahi-daemon  \
      -v /etc/localtime:/etc/localtime:ro \
      -v /var/run/dbus:/var/run/dbus \
      -e DOCKUID=<UID default:106> \
      -e DOCKGID=<GID default:111> \
         digrouz/docker-ubu-avahi

## Environment Variables

When you start the `avahi` image, you can adjust the configuration of the `avahi` instance by passing one or more environment variables on the `docker run` command line.

### `DOCKUID`

This variable is not mandatory and specifies the user id that will be set to run the application. It has default value `111`.

### `DOCKGID`

This variable is not mandatory and specifies the group id that will be set to run the application. It has default value `106`.

## Notes

* The docker entrypoint will upgrade operating system at each startup.
* It is assumed that the host is running the `dbus` daemon and share the socket through /var/run/dbus with this container. This is a requirement to have `mdns` support.
