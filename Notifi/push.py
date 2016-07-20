import time, os
from apns import APNs, Frame, Payload

cert_path = 'pushcert.pem'
# key_path = '/Users/julianhulme/signifi_certs/privKey.pem'

apns = APNs(use_sandbox=True, cert_file=cert_path, key_file='')

# Send a notification


token_julz = "4a584c09cc8a7292558bcccbd58b5db47a4d1cf90908c8dab23133083f5fc8b1"
token_david = "adb3e77d04e982b7251f020d69dccbcdf4e8d1b05988b72c0737741b50c53279"

          
successPackage = {}
successPackage["alert"] = "what's up"
successPackage["category"] = "COUNTER_CATEGORY"
successPackage["cardAmountProcessed"] = 100
successPackage["rewardsAmountProcessed"] = 7000
aps = {"aps":successPackage}

failurePackage = {}
failurePackage["notificationType"] = "TRANSACTION_FAILURE"	


payload = Payload(alert="TRANSACTION_SUCCESS", custom=aps)
result = apns.gateway_server.send_notification(token_david, payload)

