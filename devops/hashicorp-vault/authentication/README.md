
# Configure Authentication with HashiCorp Vault

## Introduction
As part of this lab, we will be required to create a policy and a token, that can be used to authenticate against a vault server.

Solution
Log in to the server using the credentials provided:

ssh cloud_user@<PUBLIC_IP_ADDRESS>
Unseal the Vault and Log in with the Root Token
In the Vault Server, retrieve the vault keys:
cat Keys
Unseal the vault:
vault operator unseal
<UNSEAL_KEY_1>
vault operator unseal
<UNSEAL_KEY_2>
vault operator unseal
<UNSEAL_KEY_3>
Log in with the Initial Root Token:
vault login
<INITIAL_ROOT_TOKEN>
Enable KV Secrets Engine and Write a Generic Test Secret
Enable a kv secrets engine at the secrets-kv path:

vault secrets enable -path=secrets-kv kv
Write a secret to the secrets-kv path:

vault kv put secrets-kv/tokenTestSecret tokenTestKey=tokenTestValue
Create a Policy That Gives Read Permissions to the KV Secrets Engine
Create a policy file named my_token_policy.hcl:
vim /home/cloud_user/my_token_policy.hcl
Populate the policy file:
path "secrets-kv/tokenTestSecret"{
    capabilities = ["read"]
}
Save the file:
ESC
:wq
ENTER
Write the policy:
vault policy write my_token_policy my_token_policy.hcl
Create a Token, Test It Out, and Then Revoke It
Create a token:

vault token create -policy="my_token_policy" -format=json | jq
Copy the client_token.

Log in with the newly created token:

vault login 
<CLIENT_TOKEN>
Attempt to read the secret:

vault kv get secrets-kv/tokenTestSecret
Attempt to write a new secret:

vault kv put secrets-kv/tokenTestSecret tokenTestValue02=tokenTestKey02
Log in with the Initial Root Token:

vault login 
<INITIAL_ROOT_TOKEN>
Revoke the client_token:

vault token revoke <CLIENT_TOKEN>
Conclusion
Congratulations — you've completed this hands-on lab!
