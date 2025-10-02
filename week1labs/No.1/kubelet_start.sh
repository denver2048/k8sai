HOST_IP=$(hostname -I | awk '{print $1}')
sudo mkdir -p /var/lib/etcd
sudo mkdir -p /etc/kubernetes/manifests
sudo mkdir -p /var/lib/kubelet
sudo mkdir -p /var/lib/kubelet/pki
sudo mkdir -p /run/containerd
sudo mkdir -p /opt/cni
sudo mkdir -p /etc/cni/net.d

sudo PATH=$PATH:/opt/cni/bin:/usr/sbin kubebuilder/bin/kubelet \
  --kubeconfig=/var/lib/kubelet/kubeconfig \
  --config=/var/lib/kubelet/config.yaml \
  --root-dir==/var/lib/kubelet \
  --cert-dir=/var/lib/kubelet/pki \
  --hostname-override=$(hostname) \
  --pod-infra-container-image=registry.k8s.io/pause:3.10 \
  --pod-manifest-path=/etc/kubernetes/manifests \
  --node-ip=$HOST_IP \
  --cloud-provider=external \
  --cgroup-driver=cgroupfs \
  -v=1 &
