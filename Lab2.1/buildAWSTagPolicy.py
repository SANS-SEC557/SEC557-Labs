#modified from: https://gist.github.com/jtroberts83/56c1abe81e273f495c6754020409b480
AWSServicesArray = ["ebs","ebs-snapshot","ec2","ec2-reserved","elb","iam-certificate","iam-group","iam-policy","iam-profile","iam-role","iam-user","internet-gateway","lambda","nat-gateway","network-acl","network-addr","r53domain","s3","security-group","sns","subnet","vpc","vpc-endpoint","vpn-connection","vpn-gateway","waf","waf-regional"]

AllPoliciesArray = ["policies:\r\n\r\n"]

template = """
- name: aws-<SERVICE_HERE>-tag-compliance
  resource: <SERVICE_HERE>
  filters:
    - "tag:Business_Unit": absent
"""

for Service in AWSServicesArray:
    ServicePolicy = template
    ServicePolicy = ServicePolicy.replace("<SERVICE_HERE>",Service)
    AllPoliciesArray.append(ServicePolicy)


AllPolicies = "\r\n\r\n".join(AllPoliciesArray)

print(AllPolicies)



