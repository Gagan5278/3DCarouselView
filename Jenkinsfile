pipeline {
    agent any 
    stages {
        stage('Example Build') {
               steps {
                xcodeBuild appURL: '',
                    assetPackManifestURL: '',
                    buildDir: '',
                    bundleID: '<App_Bundle_ID>',
                    cfBundleShortVersionStringValue: '',
                    cfBundleVersionValue: '',
                    changeBundleID: false,
                    configuration: 'Release',
                    developmentTeamID: '<Team_ID>',
                    developmentTeamName: '',
                    displayImageURL: '',
                    fullSizeImageURL: '',
                    ipaExportMethod: 'development',
                    ipaName: 'PreProd',
                    ipaOutputDirectory: '',
                    logfileOutputDirectory: '',
                    provisioningProfiles: [[provisioningProfileAppId: '', provisioningProfileUUID: '']],
                    sdk: '',
                    symRoot: '',
                    target: 'PreProd',
                    thinning: '',
                    buildIpa: true,
                    xcodeProjectFile: '/Users/gavishal/.jenkins/workspace/Money/3DCarousel/3DCarousel.xcodeproj',
                    xcodeSchema: 'PreProd',
                    xcodeWorkspaceFile: '',
                    xcodebuildArguments: ''
            }
        }
        stage('Example Test') {
            steps {
                echo 'Hello, JDK'
            }
        }
    }
}