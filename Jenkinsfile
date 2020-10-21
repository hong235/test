pipeline
{
    post
    {
        always
        {
            cleanWs deleteDirs: true, notFailBuild: true
        }
    }
	agent
    {
        dockerfile
        {
            filename 'Dockerfile'
            additionalBuildArgs '''\
                --build-arg ALKEMIST_LICENSE_KEY=74C8C4-7A9B40-8E76C9-40BFD2-48065A-V3\
                --build-arg LFR_ROOT_PATH=$LFR_ROOT_PATH\
            '''
            args '-u root:sudo'
        }
    }
    environment
    {
        REDIS_VERSION = "redis-stable"
    }
	stages
	{
		stage("Download Source")
		{
			steps
			{
				sh '''
                    wget http://download.redis.io/releases/${REDIS_VERSION}.tar.gz
				'''
			}
		}
		stage("Extract Source")
		{
			steps
			{
				sh '''
                    tar xzf ${REDIS_VERSION}.tar.gz
				'''
			}
		}
		stage("Build")
		{
			steps
			{
				sh '''
					cd ${REDIS_VERSION}
                    ${LFR_ROOT_PATH}/scripts/lfr-helper.sh make -j$(nproc)
				'''
			}
		}
        stage("Smoke Test")
        {
            steps
            {
                sh '''
                    cd ${REDIS_VERSION}/src
                    ./redis-server --version
                '''
            }
        }
	}
}
