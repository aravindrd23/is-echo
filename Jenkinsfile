podTemplate(cloud: 'kcloud', label: 'main', containers: [
    containerTemplate(
        name: 'jnlp',
        image: 'diamanti/jnlp-slave'
    ),
    containerTemplate(
        name: 'build',
        image: 'diamanti/build-tools',
        command: 'cat',
        privileged: true,
        ttyEnabled: true
    ),
    containerTemplate(
        name: 'maven',
        image: 'maven:3-alpine',
        command: 'cat',
        privileged: true,
        ttyEnabled: true
    )],
        slaveConnectTimeout: 200,
        serviceAccount : 'jenkins',
        volumes: [hostPathVolume(mountPath: '/var/run', hostPath: '/var/run')],
	annotations: [podAnnotation(key: "diamanti.com/endpoint0", value: '{"network":"blue","perfTier":"high"}' )]
	) {
    node('main') {
        def appName = 'cicd-maven'
        def imageTag = "10.5.197.144:9443/diamanti/${appName}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
        stage('checkout') {
            container('build') {
            sh('echo "[http]\n sslVerify = false" >~/.gitconfig')
                checkout scm
            }
        }
        stage('compile') {
            container('maven') {

                    //sh('''sed -i -e 's#<proxies>#<proxies><proxy><id>optional</id><active>true</active><protocol>http</protocol><host>atlproxy.tvlport.com</host><port>8080</port></proxy>#g' /usr/share/maven/conf/settings.xml''')
                    sh("cp settings.xml /usr/share/maven/conf")
                     sh("mvn -B -DskipTests clean package")
            }
        }

        stage('build') {
            container('build') {
                sh('cp Dockerfile target')
                dir('target') {
                    sh("docker build -t ${imageTag} .")
                }
            }
        }

        stage('push') {
            container('build') {
                dir('target') {
                    sh("docker push ${imageTag}")
                }
            }
        }
        stage('deploy') {
            container('build') {
                    sh("sed -i.bak 's#10.5.197.144:9443/diamanti/cicd-maven:1.0.0#${imageTag}#' k8s/*.yaml")
                    sh("kubectl apply -f k8s/")
            }
        }
    }
}

