
# 1st try

```bash

asalowi1@MGC000002932:~/Downloads > sudo vault server -dev
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201

  vault --version
  export VAULT_ADDR='http://127.0.0.1:8200'
  vault status
  export VAULT_TOKEN=*****
  vault status
  vault kv put secret/aws access_key=**** secret_key=*****
  vault kv get secret/aws
  brew install jq
  vault kv get -format=json secret/aws | jq -r
  vault kv get -format=json secret/aws | jq -r .data.data.access_key
```
https://www.vaultproject.io/api/secret/kv/kv-v2.html

```bash

curl -X GET -H "X-Vault-Token:**********" $VAULT_ADDR/v1/secret/data/aws

```

# 2nd try

## consul

```bash
asalowi1@MGC000002932:~/Downloads > consul agent -dev
==> Starting Consul agent...
==> Consul agent running!
           Version: 'v1.2.2'
           Node ID: '58e5b49c-0f38-b724-2358-20451aead600'
         Node name: 'MGC000002932.'
        Datacenter: 'dc1' (Segment: '<all>')
            Server: true (Bootstrap: false)
       Client Addr: [127.0.0.1] (HTTP: 8500, HTTPS: -1, DNS: 8600)
      Cluster Addr: 127.0.0.1 (LAN: 8301, WAN: 8302)
           Encrypt: Gossip: false, TLS-Outgoing: false, TLS-Incoming: false

==> Log data will now stream in as it occurs:

    2018/09/03 00:11:02 [DEBUG] agent: Using random ID "58e5b49c-0f38-b724-2358-20451aead600" as node ID
    2018/09/03 00:11:02 [WARN] agent: Node name "MGC000002932." will not be discoverable via DNS due to invalid characters. Valid characters include all alpha-numerics and dashes.
    2018/09/03 00:11:02 [INFO] raft: Initial configuration (index=1): [{Suffrage:Voter ID:58e5b49c-0f38-b724-2358-20451aead600 Address:127.0.0.1:8300}]
    2018/09/03 00:11:02 [INFO] raft: Node at 127.0.0.1:8300 [Follower] entering Follower state (Leader: "")
    2018/09/03 00:11:02 [INFO] serf: EventMemberJoin: MGC000002932..dc1 127.0.0.1
    2018/09/03 00:11:02 [INFO] serf: EventMemberJoin: MGC000002932. 127.0.0.1
    2018/09/03 00:11:02 [INFO] consul: Adding LAN server MGC000002932. (Addr: tcp/127.0.0.1:8300) (DC: dc1)
    2018/09/03 00:11:02 [INFO] consul: Handled member-join event for server "MGC000002932..dc1" in area "wan"
    2018/09/03 00:11:02 [DEBUG] agent/proxy: managed Connect proxy manager started
    2018/09/03 00:11:02 [INFO] agent: Started DNS server 127.0.0.1:8600 (udp)
    2018/09/03 00:11:02 [INFO] agent: Started DNS server 127.0.0.1:8600 (tcp)
    2018/09/03 00:11:02 [INFO] agent: Started HTTP server on 127.0.0.1:8500 (tcp)
    2018/09/03 00:11:02 [INFO] agent: started state syncer


    asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv put aws/config/my_ami ami-04681a1dbd79675a5
  Success! Data written to: aws/config/my_ami
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv put aws/config/my_subnet subnet-3805d964
  Success! Data written to: aws/config/my_subnet
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv put aws/config/my_ssh_key amzn-detwa-east
  Success! Data written to: aws/config/my_ssh_key
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv put aws/config/my_route53_zone_id Z20NBA4QJSYPCC
  Success! Data written to: aws/config/my_route53_zone_id
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv get aws/config
  Error! No key exists at: aws/config
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv get aws/config --recurse
  Too many arguments (expected 1, got 2)
  asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > consul kv get -recurse aws/config
  aws/config/my_ami:ami-04681a1dbd79675a5
  aws/config/my_route53_zone_id:Z20NBA4QJSYPCC
  aws/config/my_ssh_key:amzn-detwa-east
  aws/config/my_subnet:subnet-3805d964
```

## vault

https://www.vaultproject.io/intro/getting-started/deploy.html

```bash
    asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault server -config=vault/config.hcl
WARNING! mlock is not supported on this system! An mlockall(2)-like syscall to
prevent memory from being swapped to disk is not supported on this system. For
better security, only run Vault on systems where this call is supported. If
you are running Vault in a Docker container, provide the IPC_LOCK cap to the
container.
==> Vault server configuration:

             Api Address: http://127.0.0.1:8200
                     Cgo: disabled
         Cluster Address: https://127.0.0.1:8201
              Listener 1: tcp (addr: "127.0.0.1:8200", cluster address: "127.0.0.1:8201", max_request_duration: "1m30s", max_request_size: "33554432", tls: "disabled")
               Log Level: info
                   Mlock: supported: false, enabled: false
                 Storage: consul (HA available)
                 Version: Vault v0.11.0
             Version Sha: 87492f9258e0227f3717e3883c6a8be5716bf564

==> Vault server started! Log data will stream in below:

2018-09-03T00:27:35.648-0400 [INFO ] core: seal configuration missing, not initialized

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault status
Error checking seal status: Error making API request.

URL: GET http://127.0.0.1:8200/v1/sys/seal-status
Code: 400. Errors:

* server is not yet initialized
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault operator init
...

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated master key. Without at least 3 key to
reconstruct the master key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) >

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault status
Key                Value
---                -----
Seal Type          shamir
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    0/3
Unseal Nonce       n/a
Version            0.11.0
HA Enabled         true

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault operator unseal
Unseal Key (will be hidden):
Key                Value
---                -----
Seal Type          shamir
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       9484f787-af70-78bb-4b7d-61f57018a857
Version            0.11.0
HA Enabled         true
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault operator unseal
Unseal Key (will be hidden):
Key                Value
---                -----
Seal Type          shamir
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       9484f787-af70-78bb-4b7d-61f57018a857
Version            0.11.0
HA Enabled         true
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault operator unseal
Unseal Key (will be hidden):
Key                    Value
---                    -----
Seal Type              shamir
Sealed                 false
Total Shares           5
Threshold              3
Version                0.11.0
Cluster Name           vault-cluster-b988ae0f
Cluster ID             21b51c04-3a19-a642-512f-3bccbda7f736
HA Enabled             true
HA Cluster             n/a
HA Mode                standby
Active Node Address    <none>

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault login *****
Error storing token: open /Users/asalowi1/.vault-token: permission denied
Authentication was successful, but the token was not persisted. The resulting
token is shown below for your records.

Key                  Value
---                  -----
token                ****
token_accessor       3a01a2a4-a224-b0a1-a30f-b47fd1bc8966
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > sudo rm -rf ~/.vault-token
Password:
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > echo ***** > ~/.vault-token
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > cat ~/.vault-token
****

echo -n '{"access_key":"*****","secret:key":"****"}' | vault kv put secret/aws -
Success! Data written to: secret/aws

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > curl -X GET -H X-Vault-Token:**** $VAULT_ADDR/v1/secret/aws
{"request_id":"55fda8b2-6f8a-c6ca-e4e2-0b4f9dcd5855","lease_id":"","renewable":false,"lease_duration":2764800,"data":{"access_key":"****","secret:key":"****"},"wrap_info":null,"warnings":null,"auth":null}

asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault delete secret/aws
Success! Data deleted (if it existed) at: secret/aws
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vuault kv put secret/
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault kv put secret/aws @vault/aws.json
Success! Data written to: secret/aws
asalowi1@MGC000002932:~/detwa/detwa-terraform (Git:* upnorth) > vault kv get secret/aws
======= Data =======
Key           Value
---           -----
access_key    *****
secret:key    *****

```
