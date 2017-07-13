// Provider specific configs
provider "aws" {
    region = "${var.aws_region}"
}


// EC2 Instance Resource for Module
resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    key_name = "${var.key_name}"
    count = "${var.number_of_instances}"
    subnet_id = "${element(var.subnet_id, count.index)}"
    instance_type = "${var.instance_type}"
    monitoring = "${var.enable_monitoring}"
    user_data = "${element(data.template_file.bootstrap.*.rendered, count.index)}"
    private_ip = "${var.private_ip}"
    vpc_security_group_ids = ["${var.security_group_ids}"]
    iam_instance_profile = "${var.iam_instance_profile}"
    lifecycle {
        ignore_changes = ["user_data"]
    }
    root_block_device {
        volume_type = "${var.root_vol_type}"
        volume_size = "${var.root_vol_size}"        
        iops        = "${var.root_vol_iops}"
    }
    ebs_block_device {
        # Data disk Serial # 0001 
        device_name = "xvdb"
        volume_type = "gp2"
        encrypted = true
        delete_on_termination = true
        volume_size = "30"
    }
    
    
    tags {
        // created_by = "${lookup(var.tags,"created_by")}"
        // Takes the instance_name input variable and adds
        //  the count.index to the name., e.g.
        //  "example-host-web-1"
        Name = "${var.svr_name_prefix}${lower(var.environment)}-${lower(var.svr_type)}${format("%02d", count.index+01)}"
        Environment = "${var.environment}"
        Terraform = "True"
    }
}

data "template_file" "bootstrap" {        
        count    = "${var.number_of_instances}"
        template = "${file(var.user_data_file)}"

            vars {
                #newName             = "${var.svr_name_prefix}${upper(var.environment)}-${upper(var.svr_type)}${format("%02d", count.index+01)}"
                newName             = "${upper(var.environment)}${upper(var.svr_type)}${upper(format("%02d", count.index+01))}"
                svr_type            = "${var.svr_type}"
                chef_role           = "${var.chef_role}"
                chef_env            = "${var.chef_env}"
                chef_client_ver     = "${var.chef_client_ver}"
                chef_org            = "${var.chef_org}"
                chef_auto_fqdn      = "${var.chef_auto_fqdn}"
                chef_server_endpoint= "${var.chef_server_endpoint}"
                data_token          = "${var.data_token}"
                #chef_backend_ver    = "${var.chef_backend_ver}"  
            }
    }