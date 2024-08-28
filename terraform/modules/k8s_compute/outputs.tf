output "k8s_ips" {
    description = "k8s public ips controller"
    value = {
        controllers_ip = aws_instance.controllers[*].public_ip
        workers_ip : aws_instance.workers[*].public_ip
    }

}