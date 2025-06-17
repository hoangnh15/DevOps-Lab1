# Bài Thực Hành 01 - DevOps (NT548) - Nhóm <14>

Triển khai hạ tầng AWS tự động bằng Terraform và CloudFormation- bài tập thực hành 01, môn Công nghệ DevOps và Ứng dụng (NT548).

## Giới thiệu

Bài tập này chứa mã nguồn Infrastructure as Code (IaC) để tự động tạo một kiến trúc mạng VPC hoàn chỉnh trên AWS, bao gồm:

* VPC với dải CIDR xác định.
* Public và Private Subnets được phân bổ trên nhiều Availability Zones (AZs).
* Internet Gateway (IGW) cho kết nối ra Internet của Public Subnets.
* NAT Gateways (và Elastic IPs) đặt trong các Public Subnets để Private Subnets có thể truy cập Internet.
* Route Tables được cấu hình đúng cho Public và Private Subnets.
* Security Groups để kiểm soát truy cập vào EC2 instances.
* EC2 Instances: Một instance trong Public Subnet và một instance trong Private Subnet.

## Yêu cầu chuẩn bị (Prerequisites)

Trước khi chạy mã nguồn, bạn cần cài đặt và cấu hình các công cụ sau:

1.  **Terraform:** Cài đặt Terraform phiên bản mới nhất. Xem hướng dẫn cài đặt tại [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads).
2.  **AWS CLI:** Cài đặt AWS Command Line Interface. Xem hướng dẫn tại [Install AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).
3.  **AWS Account & Credentials:**
    * Có một tài khoản AWS.
    * Tạo một IAM User với quyền hạn cần thiết (ví dụ: `AdministratorAccess` cho mục đích học tập, nhưng nên dùng quyền hạn chế hơn trong thực tế).
    * Tạo **Access Key ID** và **Secret Access Key** cho IAM User đó.
    * Chạy lệnh `aws configure` trong terminal/powershell và nhập Access Key ID, Secret Access Key, Default region name (ví dụ: `us-east-1`), và Default output format (`json`). Terraform sẽ sử dụng thông tin này để xác thực.
4.  **AWS Key Pair:** Tạo một EC2 Key Pair trên AWS Console tại Region bạn sẽ triển khai (ví dụ: `us-east-1`). Đặt tên cho Key Pair này là `N14-Lab1` (hoặc tên đã cấu hình trong `Terraform/variables.tf`) và tải file `.pem` về máy.
5.  **Git:** Cài đặt Git để clone repository(nếu cần thiết).

## Cấu trúc thư mục
```
DEVOPS-LAB1/
├── Cloudformation/     # Chứa mã nguồn CloudFormation
├── Terraform/          # Chứa mã nguồn Terraform
│   ├── main.tf         # File main gọi các module
│   ├── variables.tf    # Khai báo biến toàn cục
│   ├── outputs.tf      # Khai báo output toàn cục
│   ├── provider.tf     # Cấu hình AWS provider
│   └── modules/        # Thư mục chứa các module con tái sử dụng
│       ├── vpc/
│       ├── security_groups/
│       └── ec2/
├── *.pem        # !!! File private key - KHÔNG PUSH LÊN GIT !!!
├── .gitignore          # Khai báo các file/thư mục bỏ qua khi commit
└── README.md           
```
## Hướng dẫn chạy Terraform

1.  **Clone Repository (Nếu cần):**
    ```bash
    git clone <URL_repository_cua_ban>
    cd DEVOPS-LAB1
    ```
2.  **Di chuyển vào thư mục Terraform:**
    ```bash
    cd Terraform
    ```
3.  **Kiểm tra và Cập nhật Variables:**
    * Mở file `variables.tf`.
    * **Xác nhận/Cập nhật** giá trị `default` cho biến `my_ip` thành địa chỉ IP Public **hiện tại** của máy + `/32` (ví dụ: `"1.2.3.4/32"`).
    * **Xác nhận** giá trị `default` cho các biến `aws_region`, `ec2_ami_id`, `ec2_key_pair_name` (`N14-Lab1`) là chính xác cho môi trường và tài khoản AWS. Đảm bảo AMI ID tồn tại và Key Pair đã được tạo trong Region đã chọn.
4.  **Khởi tạo Terraform:**
    Chạy lệnh này để tải về các plugin cần thiết cho AWS provider và khởi tạo các module con.
    ```bash
    terraform init
    ```
5.  **Kiểm tra Kế hoạch:**
    Xem Terraform dự định sẽ tạo/thay đổi/xóa những tài nguyên nào. Bước này giúp kiểm tra lỗi cú pháp và logic trước khi áp dụng.
    ```bash
    terraform plan
    ```
6.  **Triển khai Hạ tầng:**
    Thực thi kế hoạch và tạo các tài nguyên trên AWS. Terraform sẽ yêu cầu xác nhận.
    ```bash
    terraform apply
    ```
    Nhập `yes` khi được hỏi `Do you want to perform these actions?`. Quá trình này có thể mất vài phút. Sau khi hoàn thành, các giá trị output (như IP của EC2) sẽ được hiển thị.
7.  **Dọn dẹp Hạ tầng (QUAN TRỌNG):**
    Sau khi sử dụng xong và để tránh phát sinh chi phí không mong muốn (đặc biệt từ NAT Gateway), hãy xóa toàn bộ tài nguyên đã tạo.
    ```bash
    terraform destroy
    ```
    Nhập `yes` khi được hỏi xác nhận.





## Kiểm tra:

Sau khi chạy `terraform apply`:

* Kiểm tra các tài nguyên đã được tạo trên AWS Management Console (VPC, Subnets, EC2, IGW, NAT GW, Route Tables, Security Groups).
* Sử dụng các giá trị output từ Terraform (ví dụ: `public_ec2_public_ip`) để thực hiện các bước kiểm tra kết nối:
    * SSH từ máy local vào Public EC2.
    * Copy/Load file key `.pem` lên Public EC2.
    * SSH từ Public EC2 vào Private EC2.
    * Kiểm tra kết nối Internet từ cả Public và Private EC2 (`ping`, `curl`).
* Tham khảo bảng Test Cases chi tiết trong file báo cáo Word để thực hiện kiểm tra đầy đủ.

## Outputs

Các thông tin quan trọng như ID tài nguyên, địa chỉ IP của các máy ảo EC2 sẽ được hiển thị ở cuối output của lệnh `terraform apply`.
