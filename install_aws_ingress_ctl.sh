#!/bin/bash

# Prerequisites
# Replace these variables with your own values
CLUSTER_NAME="thecloudshepherd"
AWS_ACCOUNT_ID="335055665325"
REGION="us-east-1"  # Change to your desired region
VPC_ID="vpc-0b07e8b1b4d574481"  # Replace with your VPC ID

# 1. Create an IAM policy
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.5.4/docs/install/iam_policy.json
aws iam create-policy \
  --policy-name AWSLoadBalancerControllerIAMPolicy \
  --policy-document file://iam_policy.json

# 2. Create an IAM role for Kubernetes service account
eksctl create iamserviceaccount \
  --cluster="$CLUSTER_NAME" \
  --namespace=kube-system \
  --name=aws-load-balancer-controller \
  --role-name AmazonEKSLoadBalancerControllerRole \
  --attach-policy-arn="arn:aws:iam::$AWS_ACCOUNT_ID:policy/AWSLoadBalancerControllerIAMPolicy" \
  --approve

# 3. Uninstall the AWS ALB Ingress Controller if previously installed
# Skip this step if not previously installed

# 4. Install the AWS Load Balancer Controller using Helm
# Helm repository setup
helm repo add eks https://aws.github.io/eks-charts
helm repo update eks

# Install the controller
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName="$CLUSTER_NAME" \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller

# 5. Verify the installation
kubectl get deployment -n kube-system aws-load-balancer-controller
