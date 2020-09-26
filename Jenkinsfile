pipeline {
   agent any

   stages {
      stage('Checkout') {
         steps {
        checkout([
            $class: 'GitSCM',
            branches: [[name: '*/master']],
            doGenerateSubmoduleConfigurations: false,
            extensions: [], submoduleCfg: []
        ])
         }
      }
        stage('Build') {
            steps {
                xcodeBuild appURL: '',
                    assetPackManifestURL: '',
                    buildDir: '',
                    bundleID: 'za.co.momentum.multiply.money',
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
                    xcodeProjectFile: '',
                    xcodeSchema: 'PreProd',
                    xcodeWorkspaceFile: '/Users/gavishal/.jenkins/workspace/Path',
                    xcodebuildArguments: ''
            }
        }
        stage('Archive') {
            steps {
                archiveArtifacts 'build/Release-iphoneos/PreProd.ipa'
            }
        }
        stage('Deploy') {
            steps {
               // sh 'cd /Applications/Transporter.app/Contents/Frameworks/ITunesServices.framework/Versions/A/Frameworks/ITunesSoftwareService.framework/Versions/A/Support/ \n xcrun altool --upload-app -f "/Users/gavishal/.jenkins/workspace/MomentumApp/build/Release-iphoneos/PreProd.ipa" -u gagan5278@gmail.com -p Devi_Asha123'
            }
        }
   }
}