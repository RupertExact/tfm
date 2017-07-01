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
    
    
    
    tags {
        // created_by = "${lookup(var.tags,"created_by")}"
        // Takes the instance_name input variable and adds
        //  the count.index to the name., e.g.
        //  "example-host-web-1"
        Name = "${var.svr_name_prefix}${lower(var.svr_type)}-${lower(var.environment)}${format("%02d", count.index+01)}"
    }
}

data "template_file" "bootstrap" {        
        count    = "${var.number_of_instances}"
        template = "${file(var.user_data_file)}"

            vars {
                newName            = "${upper(var.svr_type)}-${upper(var.environment)}${format("%02d", count.index+01)}"
                svr_type           = "${var.svr_type}"
                chefRole           = "${var.chef_role}"
                chefEnvironment    = "${var.chef_env}"
                chefClientVer      = "${var.chefClientVer}"
                chefOrg            = "${var.chefOrg}"
                chefAutoFqdn       = "${var.chefAutoFqdn}"
                chefServerEndpoint = "${var.chefServerEndpoint}"
                dataToken          = "${var.dataToken}"
            }
    }