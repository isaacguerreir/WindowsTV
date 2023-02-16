# WindowsTV 
## A node server to let you connect a Windows computer to a Wireless Display 

I'm trying to automatize my workflow as much as possible. Sometimes I'm tired of sitting at my desk and I like to use my living room to program using a wireless keyboard and mouse. It will be really nice to go to the living room, turn on the TV, and using a ssh command to my Windows computer IP address to connect my PC via Wireless Display.

I created a powershell script (yeah, what man do for confortable) with the expectation to run via SSH, however Windows documentation is horrible and ssh connections have a lot of limitations even run as root (not send keystrokes or permission to run some UWP libraries). So my solution right now it's basically run a node server that could run my script from inside so everything works.  

So, I would like to say. I'm not responsible for whatever you with this. Try not to put youserlf at risk, ok?

### Prerequesites

```{bash}
chocolatey

## You can install node using nvm.
choco install nvm
nvm install 16
nvm use 16.19.0

node -v
```

### To connect to your tv

First, change line 5 of `connect.ps1` file inside `scripts` folder passing exact name of you TV as parameter.

```
$tv_name = "MY_TV_NAME"
```

So now it's only a matter of install and execute.

```
npm install
npm start
```

Remember to check if you firewall is on for local network.
