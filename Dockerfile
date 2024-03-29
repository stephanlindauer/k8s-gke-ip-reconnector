FROM ubuntu:18.04

RUN apt-get update -y && \
    apt-get install -y \
    curl \
    jq \
    lsb-release \
    gnupg2

# install kubectl
RUN curl -O https://storage.googleapis.com/kubernetes-release/release/v1.13.11/bin/linux/amd64/kubectl && \
    mv kubectl /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# install gcloud
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install google-cloud-sdk -y

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh" ]
