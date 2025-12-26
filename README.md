# AWS Certificate Manager (ACM) 🥇

AWS Certificate Manager is a fully managed service responsible for the issuance, validation and management of SSL/TLS certificates for encryption of data in transit. AWS ACM removes the operational overhead of expired certificates and removes manual certificate management in your AWS environment. 

This service can be integrated with 

1. Application Load Balancer (listener on port 443 needs a ACM)
2. Network Load Balancer
3. Amazon Cloud Front
4. Amazon API Gateway

# SSL/TLS Encryption and TLS termination 🔒

HTTPS traffic flow from the public internet and reaches the ALB. The ALB performs TLS termination (decryption) and traffic forwarded to your target group in your private subnet over HTTP. The ALB is configured with AWS WAF for OWASP top 10 compliance such as SQL injection, XML external entities and insecure deserialization. AWS ACM is also configured with the ALB for the issuance, validation and management of SSL/TLS certificates. 

Internet Protocols than can use SSL/TLS encryption 

HTTP port 80 → SSL/TLS → HTTPS port 443

SMTP port 25 → SSL/TLS → SMTPS port 465/587

POP3 port 110 → SSL/TLS → POP3S port 995

IMAP port 143 → SSL/TLS → IMAPS port 993

🚨 The purpose of SSL/TLS encryption is for data in transit to prevent eavesdropping and Man In the Middle attacks where a data packet can be intercepted by a threat actor. 
