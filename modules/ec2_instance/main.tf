// Provider specific configs
provider "aws" {
    region = "${var.aws_region}"
}


// EC2 Instance Resource for Module
resource "aws_instance" "ec2_instance" {
    ami = "${var.ami_id}"
    key_name = "${var.key_name}"
    count = "${var.number_of_instances}"
    subnet_id = "${var.subnet_id}"
    instance_type = "${var.instance_type}"
    monitoring = "${var.enable_monitoring}"
    user_data = "${element(data.template_file.bootstrap.*.rendered, count.index)}"
    #private_ip = "${var.private_ip}"
    #vpc_security_group_ids = "${var.vpc_security_group_ids}"
    #iam_instance_profile = "${var.iam_instance_profile}"
    lifecycle {
        ignore_changes = ["user_data"]
    }
    root_block_device {
    volume_type = "gp2"
    volume_size = "${var.root_vol_size}"
    }
    data "template_file" "bootstrap" {        
        count    = "${var.number_of_instances}"
        template = "${file("./files/userdata.ps1")}"

            vars {
                newName            = "${upper(var.svr_type)}${upper(var.environment)}${format("%02d", count.index+01)}"
                svr_type           = "${var.svr_type}"
                chefRole           = "${var.chef_role}"
                chefEnvironment    = "${var.chef_env}"
                chefClientVer      = "${var.chefClientVer["windows"]}"
                chefOrg            = "${var.chefOrg}"
                chefAutoFqdn       = "${var.chefAutoFqdn}"
                chefServerEndpoint = "${var.chefServerEndpoint}"
                dataToken          = "${var.dataToken}"
            }
    }

    tags {
        created_by = "${lookup(var.tags,"created_by")}"
        // Takes the instance_name input variable and adds
        //  the count.index to the name., e.g.
        //  "example-host-web-1"
        Name = "${var.instance_name}-${count.index}"
    }
}