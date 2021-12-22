import os

version= "python3 __init__.py"
os.system(version)
print("\n")

ch = "chmod +rx 'Cerberus Firewall.sh'"
os.system(ch)

localnet= "ifconfig"
publicIP= "curl ifconfig.me"
print("CHECKING LOCAL NET STATUS...\n")
os.system(localnet)
print("\n")
print("YOUR PUBLIC IP ADDRESS: \n")
os.system(publicIP)
print("\n")

ch_config_file = "chmod +rx Config.sh"
config= "bash Config.sh"
os.system(ch_config_file)
os.system(config)
print("\n")

firewall= "bash 'Cerberus Firewall.sh'"

try:
 os.system(firewall)
except:
 print("""
       Oops! something went wrong...
       Please try running again this program
       If this problem occurs again, report the issue
       to this email: Cyberronin0101@protonmail.com
       or to this instagram account: renato_calore
       or to this github account: https://github.com/Taxiarchos
       """)