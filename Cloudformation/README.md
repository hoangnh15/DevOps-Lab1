# DevOps Lab 1 - CloudFormation Infrastructure Deployment

## 📦 Mô tả

Dự án này triển khai hạ tầng AWS sử dụng AWS CloudFormation với cấu trúc **nested stacks (module-based)**, bao gồm:

* VPC
* Subnets
* Route Tables
* Security Groups
* EC2 Instance

Tất cả tài nguyên được định nghĩa theo module nằm trong thư mục `modules/`. Stack chính gọi các module này thông qua file `main.yaml`.

---

## 📁 Cấu trúc thư mục

```
Cloudformation/
│
├── modules/
│   ├── vpc.yaml
│   ├── subnets.yaml
│   ├── route-tables.yaml
│   ├── security-groups.yaml
│   └── ec2.yaml
│
├── N14-Lab1.pem                  # SSH key pair để truy cập EC2
├── main.yaml                     # File tổng hợp (nếu cần gọi thêm)
├── output.txt                    # Ghi log đầu ra
├── complete-stack.yaml           # Stack chính (parent stack)
└── README.md                     # Hướng dẫn triển khai
```

---

## 🚀 Cách triển khai

### ✅ Điều kiện tiên quyết

* Tài khoản AWS có quyền tạo CloudFormation stack và tài nguyên (VPC, EC2…)
* AWS CLI đã cài đặt và cấu hình (`aws configure`)
* File `N14-Lab1.pem` phải tồn tại và được tạo từ trước trong AWS EC2 Key Pairs

---

### 🛠️ Bước 1: Upload các file module lên S3

```bash
aws s3 mb s3://<your-bucket-name>
aws s3 cp modules/ s3://<your-bucket-name>/modules/ --recursive
```

---

### 🛠️ Bước 2: Deploy stack chính

```bash
aws cloudformation create-stack \
  --stack-name devops-lab1 \
  --template-body file://Cloudformation/modules/complete-stack.yaml \
  --capabilities CAPABILITY_NAMED_IAM
```

**Lưu ý:** Nếu `complete-stack.yaml` gọi các nested stack qua S3, bạn cần sửa các đường dẫn trong file đó theo:

```yaml
TemplateURL: https://s3.amazonaws.com/<your-bucket-name>/modules/vpc.yaml
```

---

### 🛠️ Bước 3: Kiểm tra và đăng nhập EC2

Sau khi stack được tạo thành công:

```bash
aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output text
```

Đăng nhập vào EC2:

```bash
ssh -i N14-Lab1.pem ec2-user@<Public-IP>
```

---

## 🪩 Cleanup - Xoá tài nguyên

```bash
aws cloudformation delete-stack --stack-name devops-lab1
```

---

## 📝 Ghi chú

* File `main.yaml` hoặc `template.yaml` có thể dùng làm bài thử nghiệm bổ sung hoặc cấu trúc khác.
* Nếu triển khai bị lỗi, kiểm tra lại các dependency giữa các stack/module và đảm bảo KeyPair đã tồn tại.


