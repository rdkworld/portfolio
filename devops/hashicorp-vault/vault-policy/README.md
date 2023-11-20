
# Write and Test a HashiCorp Vault Policy

## Introduction
As part of this lab, we will need to create two policies for two paths and define different permissions. Once the policies are in place, we can assign them to tokens and test out access to the paths.

Use dig to get the domain name of the server, or open the Domain file:
dig -x <SERVER PUBLIC IP>
cat /home/cloud_user/Domain
Vault keys and root token are located at:
/home/cloud_user/Keys
Solution
Log in to the server using the credentials provided:

ssh cloud_user@<PUBLIC_IP_ADDRESS>
Log in with Root Token and Unseal Vault
Enter the following command:
cat Keys
Unseal the vault:
vault operator unseal <KEY>
Repeat the above command to unseal each key.

Log in with root token:
cat Keys
vault login <ROOT TOKEN>
Enable kv Secrets Engine at Two Paths
Enable kv secrets engine at secrets-kv-X path:
vault secrets enable -path=secrets-kv-X kv
Enable kv secrets engine at secrets-kv-Y path:
vault secrets enable -path=secrets-kv-Y kv
Create a Policy that Allows Read Access at secrets-kv-X Path and Write Access at secrets-kv-Y Path
Create a policy file:
vim XY.hcl
In the pop-up message, click Remove unprintable.

Set the parameters:
path "secrets-kv-X/*"{
       capabilities = ["create"]
}
path "secrets-kv-Y/*"{
       capabilities = ["read"]
}
To quit: * Hit ESC * Type :wq * Hit ENTER

Write the policy:
vault policy write XY XY.hcl
Create a Policy that Allows Read Access at secrets-kv-Y Path and Write Access at secrets-kv-X Path
Create a policy file:
vim YX.hcl
In the pop-up message, click Remove unprintable.

Set the parameters:
path "secrets-kv-Y/*"{
       capabilities = ["create"]
}
path "secrets-kv-X/*"{
       capabilities = ["read"]
}
To quit: * Hit ESC * Type :wq * Hit ENTER

Write the policy:
vault policy write YX YX.hcl
Create Two Tokens, Each with One Policy and Test It Out!
Create token with policy XY:
vault token create -policy=XY -format=json | jq
Copy the client token into a text editor.

Create token with policy YX:
vault token create -policy=YX -format=json | jq
Copy the client token into a text editor.

Log in with the token for policy XY:
vault login
Paste in the client token for policy XY.

Test token with policy XY:
vault kv put secrets-kv-X/my-kv-secret username=password
The above command should be successful.

vault kv put secrets-kv-Y/my-kv-secret username=password
The above command should fail.

vault kv get secrets-kv-X/my-kv-secret
The above command should fail.

vault kv get secrets-kv-Y/my-kv-secret
Log in with the token for policy YX:
vault login
Paste in the client token for policy YX.

Test token with policy YX:
vault kv put secrets-kv-X/my-kv-secret username=password
The above command should fail.

vault kv put secrets-kv-Y/my-kv-secret username=password
The above command should be successful.

vault kv get secrets-kv-X/my-kv-secret
The above command should be successful.

vault kv get secrets-kv-Y/my-kv-secret
The above command should fail.

Conclusion
Congratulations — you've completed this hands-on lab!
