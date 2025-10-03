# ENGR_433

## Installing needed dependencies
Follow oss-cad-suite [guide](https://github.com/YosysHQ/oss-cad-suite-build) to install needed binaries or follow the following steps for a Linux machine.

```bash
wget https://github.com/YosysHQ/oss-cad-suite-build/releases/download/2025-10-01/oss-cad-suite-linux-x64-20251001.tgz
mkdir ~/opt
tar -xvzf oss-cad-suite-linux-x64-20251001.tgz -C ~/opt
echo 'export PATH=~/opt/oss-cad-suite/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
```
