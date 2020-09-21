FROM jenkins/jenkins:2.249.1-lts-slim
 
USER root
COPY jenkins-entrypoint.sh /entrypoint.sh 
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
CMD ["/sbin/tini", "--", "/usr/local/bin/jenkins.sh"]

