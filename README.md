# RenTool

## Installation and Building Prerequisites

### JDK 21 +
For consistency reasons, JDK-21 (newest LTS as of 2023-11) or newer should be used.

#### Linux
For debain based systems, simply run (with sufficient permissions if needed ```sudo```):
```
apt update; apt install java
```

#### Windows
Download open jdk package from [here](https://download.java.net/java/GA/jdk21.0.1/415e3f918a1f4062a0074a2794853d0d/12/GPL/openjdk-21.0.1_windows-x64_bin.zip) or any other major source. Then unpack the zipped folder within to an appropriate folder, such as:
```
C:\Program Files\Java\jdk-21.x\
```
Then edit your **system** environment variables *not user environment variables* by setting the variable **JAVA_HOME** to the newly unpacked folder, and appending java to your system path if not already present.
```
%JAVA_HOME%=C:\Program Files\Java\jdk-21.x
```
```
PATH=[existing paths];%JAVA_HOME%\bin
```

### Docker (and docker compose)
Docker is used to run and orchestrate the containers that RenTool runs in. This is done for cross platform compatibility and for development/deployment consistency between developers/machines.

#### Linux
For debian based systems, simply run (with sufficient permissions if needed ```sudo```):
```bash
apt update; apt install docker docker-compose
```

#### Windows

##### Part 1: WSL (Windows subsystem Linux)
Windows machines need to have wsl (Windows subsystem Linux) installed/enabled to install docker. If it is not already installed/enabled, run the following in an administrator privileged command prompt or power shell:
```powershell
wsl --install
```
Allow for wsl to install, the default linux OS is fine, and set the Linux/UNIX username & password as desired (it should not affect docker, choose something you will remember if you wish to use wsl later).

##### Part 2: Docker Desktop
Download and install docker desktop according to the installer from docker [here](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe). Since we are using docker for academic purposes, we are exempt from the restrictions of the docker desktop license, so accept it, no login to docker hub is required. ***NOTE:** The docker license is only applicable to docker desktop installations, so if you do not wish to accept the license, install docker according to the linux instructions by running all commands within WSL command prompt or in a linux virtual machine.*

### Gradle
Gradle is used for building the project from source and for providing platform independent shortcuts to start, stop, and deploy to the docker containers. **VERSION 8.4.X MUST BE USED!**

#### Linux
Use *SDKMAN!* to install Gradle. There are other methods but they have a tendency to install older, outdated versions. Follow the directions [here](https://sdkman.io/install) to install *SDKMAN!*. Then run the following (with sufficient permissions if needed ```sudo```):
```bash
sdk install gradle 8.4
```

#### Windows
Download Gradle 8.4 from [here](https://gradle.org/next-steps/?version=8.4&format=all). Then unpack the zipped folder within to an appropriate folder such as:
```
C:\Program Files\Gradle\gradle-8.4
```
Then edit your **system** environment variables *not user environment variables* by setting the variable **GRADLE_HOME** to the newly unpacked folder, and appending gradle to your system path if not already present.
```
%GRADLE_HOME%=C:\Program Files\Gradle\gradle-8.4
```
```
PATH=[existing paths];%GRADLE_HOME%\bin
```