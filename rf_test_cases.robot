*** Settings ***
Library  OperatingSystem
Library  Process
Library  Collections
Library  SeleniumLibrary
Suite Setup    Start setup
*** Variables ***


*** Test Cases ***
NIC config before setting NIC
    [Tags]  Ping vms
    Sleep  50s 	Waiting for Vms to boot up. 	
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  print_nic.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}

Ping VMs before setting NIC
    [Tags]  Ping vms
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  try_ping.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Should Contain  ${result.stdout}  100% packet loss
    Log  ${result.stdout}

Set NIC
    [Tags]  Ping vms
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  set_nic.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    ${ifconfig} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  print_nic.py  runserver
    Should Contain X Times  ${result.stdout}  successful  2  msg=Setting NIC was unsuccessful
    Should Contain X Times  ${ifconfig.stdout}  enp0s9  2  msg=Setting NIC was unsuccessful
    Should Contain  ${ifconfig.stdout}  10.2.0.23  msg=Setting NIC for VM n1 was unsuccessful  values=False
    Should Contain  ${ifconfig.stdout}  10.2.0.24  msg=Setting NIC for VM n2 was unsuccessful  values=False
    Log  ${result.stdout}
    Log  ${ifconfig.stdout}

Ping VMs after setting NIC
    [Tags]  Ping vms	
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  try_ping.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Should Contain X Times  ${result.stdout}  0% packet loss  2  msg=Ping successful
    Log  ${result.stdout}

NIC config after setting NIC
    [Tags]  Ping vms
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\ping_vms\\.venv\\Scripts\\python.exe  print_nic.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}
    Terminate process  vm1  kill=true
    Terminate process  vm2  kill=true




Graph temperature BB
    [Tags]  Plotly
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\plotly_graphs\\venv\\Scripts\\python.exe  temperature_lch.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}

Graph networkx
    [Tags]  Plotly + Networkx
    ${result} =  Run Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\plotly_graphs\\venv\\Scripts\\python.exe  networkx_plo.py  runserver
    Should Be Empty  ${result.stderr}  msg=${result.stderr}
    Log  ${result.stdout}




Test GET
    [Tags]  Postman + Wamp 
    ${chrome options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${ChromeOptions}    add_extension    lhobafahddgcelffkeicbaginigeejlf.crx
    ${Options}=     Call Method         ${ChromeOptions}    to_capabilities      
    Open Browser    https://www.postman.com/   Chrome     alias=main       desired_capabilities=${Options}
    
    Execute Javascript	window.open()
    Switch Window	locator=NEW
    Go To	chrome-extension://lhobafahddgcelffkeicbaginigeejlf/data/popup/popup.html
    Click Element  xpath://html/body/div[1]/table/tbody/tr/td[1]/table/tbody/tr/td
    Close window
    Switch Window  locator=main


    Wait Until Page Contains Element  xpath://*[@id="gatsby-focus-wrapper"]/main/nav/ul/li/a  timeout=20s
    Click Element  xpath://*[@id="gatsby-focus-wrapper"]/main/nav/ul/li/a
    Wait Until Page Contains Element  id:username  timeout=20s
    Input Text  id:username  mekkyzbirka@gmail.com
    Input Text  id:password  Test@12345

    Wait Until Page Contains Element  xpath://*[@id="sign-in-btn"]  timeout=20s
    Click Element  xpath://*[@id="sign-in-btn"]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div/div[1]/aside/div/div[2]/a[1]/div/div  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div/div[1]/aside/div/div[2]/a[1]/div/div
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/main/div/ol/li[2]/div[1]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/main/div/ol/li[2]/div[1]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[6]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[1]/div/div[6]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[4]/div/div/div[2]/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[4]/div/div/div[2]/div[2]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]
    Sleep  5s

Test POST
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[3]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[3]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Sleep  5s

Test GET after POST
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]
    Sleep  5s

Test PUT
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[7]/div/div/div[2]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[4]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[4]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Sleep  5s

Test GET after PUT
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[9]/div/div/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[9]/div/div/div[2]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]
    Sleep  5s

Test DELETE
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[8]/div/div/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[8]/div/div/div[2]
    Wait Until Page Contains Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[5]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath://html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[5]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Sleep  5s

Test GET after DELETE
    [Tags]  Postman + Wamp
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[11]/div/div/div[2]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[1]/div[1]/div/div/div[2]/div[2]/div/div/div/div[2]/div[1]/div/div/div[11]/div/div/div[2]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[2]/div/div[2]/div/div/div/div/div[1]
    Wait Until Page Contains Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]  timeout=20s
    Click Element  xpath:/html/body/div[3]/div/div/div[5]/div[1]/div[1]/div/div/div/div[2]/div/div/div/div[2]/div[2]/div/div/div/div/div[1]/div[1]/div/div[3]/div[2]/div/div[2]/div[2]/div/div/div/div/div/div/div/div/div/div[1]/div[1]/div[1]/div[3]
    Sleep  5s


*** Keywords ***
Start setup
    Start Process  C:\\Users\\oliver.uhlar\\Desktop\\Projects\\postman_wamp\\venv\\Scripts\\python.exe  app.py  runserver
    Start Process  wamp.bat
    Start process  C:\\Program Files\\Oracle\\VirtualBox\\VirtualBoxVM.exe  --comment  ubuntu_1  --startvm  {c0382caa-6ce6-4fd3-aab4-77ea96bff7f7}  alias=vm1
    Start process  C:\\Program Files\\Oracle\\VirtualBox\\VirtualBoxVM.exe  --comment  ubuntu_2  --startvm  {dbe30ee1-7145-48e6-9a9a-2a7c6b910257}  alias=vm2

