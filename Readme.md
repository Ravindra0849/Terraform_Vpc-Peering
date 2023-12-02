
# Creating a Vpc Peering between 2 Vpc's.

Steps For VPC peering Connection:

    1. Create 2 Vpc's with different Cidr_blocks
    2. Create 2 Subnets using above Vpc's
    3. Create an Internet Gateway for both Vpc's
    4. Create Route tables
    5. Create Route Table Association
    6. Create Security Groups for SSH and HTTP ports
    7. Create 2 EC2 Instances using above Vpc's and Security Groups
    8. Create a Vpc Peering Between 2 Vpc's
    9. Create route table for Vpc's Peering
    10. ping each instances with other instance using "curl" command.

==> After successfully Creation of Vpc Peering 

    Connect to instance-1  with git bash

    Connect to instance-2  with git bash in another tab

==> execute the commands in instance-1 as

    curl <private ip of instance-2>

==> Same in Instance-2 git bash also 

    curl <private Ip of instance-1>

it will shows the Outputs as 

![Alt text](<Screenshot 2023-12-02 123304.png>)

![Alt text](<Screenshot 2023-12-02 123329.png>)

