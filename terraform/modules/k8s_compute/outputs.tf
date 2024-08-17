output "k8s_ips" {
    description = "k8s public ips controller"
    value = {
        controllers_ip = aws_instance.controllers[*].public_ip
        # workers_ip : aws_instance.workers[*].public_ip
    }

}
# output "k8s_ips_yml" {
#     description = "k8s public ips controller"
#     value = {
#         controllers : zipmap(aws_instance.controllers[*].public_ip,[""])
#         all : {
#             vars : {
#                 ansible_user : "ubuntu"
#                 ansible_connection : "ssh"
#             }
#         }

#         # workers : aws_instance.workers[*].public_ip
#     }

# }
# output "worker_public_ips" {
#     value = values(aws_instance.workers.map).public_ip
#     sensitive = true
# }