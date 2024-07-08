<<<<<<< HEAD
# CuriousOrg
=======
# Salesforce DX Project: Next Steps

Now that you’ve created a Salesforce DX project, what’s next? Here are some documentation resources to get you started.

## How Do You Plan to Deploy Your Changes?

Do you want to deploy a set of changes, or create a self-contained application? Choose a [development model](https://developer.salesforce.com/tools/vscode/en/user-guide/development-models).

## Configure Your Salesforce DX Project

The `sfdx-project.json` file contains useful configuration information for your project. See [Salesforce DX Project Configuration](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_ws_config.htm) in the _Salesforce DX Developer Guide_ for details about this file.

## Read All About It

- [Salesforce Extensions Documentation](https://developer.salesforce.com/tools/vscode/)
- [Salesforce CLI Setup Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_intro.htm)
- [Salesforce DX Developer Guide](https://developer.salesforce.com/docs/atlas.en-us.sfdx_dev.meta/sfdx_dev/sfdx_dev_intro.htm)
- [Salesforce CLI Command Reference](https://developer.salesforce.com/docs/atlas.en-us.sfdx_cli_reference.meta/sfdx_cli_reference/cli_reference.htm)
>>>>>>> master
For new github repository setup for the Salesforce Org metadata 

	1. Download the Java and the VsCode and install the Sfdx on the system and the salesforce extensions
	2. Open the Vscode Use Ctrl + Shift + P and >SFDX : Create Project with Manifest option and all things will be added related to salesforce project with this step that takes the input of the Name and the Folder 
	3. Again Ctrl + Shift + p then enter >SFDX : Authorize an org and then it will redirected to the salesforce login and after we can retrive the metadata in the vscode
	4. Login to the github and create new repository with the Proper Project name.
	5. Naviagte to the Vscode and go to terminal and enter the git init to initilize the repository.
	6. Type git remoter add origin https://github.com/your-username/your-repo-name.git and then enter the link from the you newly created github repo where we need to store our salesforce org metadata
	7. In the manifest folder of the salesforce project open the package.xml file and enter the metadata type that we need to retrive and then right click select the SFDX retrive from the org and now you can see the changes in the source tree.
	8. On terminal now use git add . and then enter it will add all the files in source tree to stage changes and the git commit -m "Initial commit of Salesforce metadata"  then press enter and then type git push -u origin main then press enter with this all the changes will be shown on the github repository in the main branch
	9. Now for future we need to connect with that github repo and the add the change in the new branch and then push the change and follow the compare and pull request thing in the github to merge the branch changes in the main branch.