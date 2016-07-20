import time, os
from apns import APNs, Frame, Payload

cert_path = 'pushcert.pem'
# key_path = '/Users/julianhulme/signifi_certs/privKey.pem'

apns = APNs(use_sandbox=True, cert_file=cert_path, key_file='')

# Send a notification

token_hex = "4a584c09cc8a7292558bcccbd58b5db47a4d1cf90908c8dab23133083f5fc8b1"
          
successPackage = {}
successPackage["alert"] = "TRANSACTION_SUCCESS"
successPackage["discountAmountProcessed"] = 5000
successPackage["cardAmountProcessed"] = 100
successPackage["rewardsAmountProcessed"] = 7000
aps = {"aps":successPackage}

failurePackage = {}
failurePackage["notificationType"] = "TRANSACTION_FAILURE"	

payload = Payload(alert="TRANSACTION_SUCCESS", custom=aps)
result = apns.gateway_server.send_notification(token_hex, payload)

