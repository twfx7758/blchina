#!/bin/bash
echo "---------------------------------------------............-------------------------------------------------------------------------"
app=$1
source ~/k8s/kube-script/input/"$app"_proj_env

#====================================================........................====================================================================#

echo "------------------------------------------------......Dockerfile---------------------------------------------------------------------"
cat <<EOF > $workspace/Dockerfile
FROM $base_img

LABEL pandora="V3.5.0"

ADD $jar_path/app.jar $jar_path/$taobao_jar /home/

WORKDIR /home/

EOF

echo "--------------------------------------------------- copy jar ----------------------------------------------------------------------"
cd `dirname $0`
sudo mv $workspace/$jar_path/${proj_name}*.jar $workspace/$jar_path/app.jar
sudo cp $m2_dir/$taobao_jar $workspace/$jar_path/$taobao_jar

echo "---------------------------------------------..................Deployment------------------------------------------------------------------"

deployment_name=$(sudo /usr/local/bin/kubectl --kubeconfig $kubeconfig get deployment -l app=$app -n $namespace|grep $app|cut -d " " -f 1)

if [  ! -n  "$deployment_name" ];then

new_img_num=1

echo "--------------------------------------------Deployment.........,..............."$app"_"$new_img_num"-------------------------------------------"
cd $workspace && sudo docker build -t $docker_repo:"$app"_"$new_img_num" .
sudo docker push $docker_repo:"$app"_"$new_img_num"
sudo docker rmi $docker_repo:"$app"_"$new_img_num"                                                                                                    
                                                                                                                                                      
echo "-------------------------------------------------......edas......------------------------------------------------------------------------"      
                                                                                                                                                      
                                                                                                                                                      
if [ "$edas_type" = 2 ];then                                                                                                                          
                                                                                                                                                      
echo "-------------------------------------------------...............edas-------------------------------------------------------------------------"  
                                                                                                                                                      
. ~/k8s/kube-script/jenkins-script/build-deployment-rke.sh $app $new_img_num                                                                          
                                                                                                                                                      
else                                                                                                                                                  
echo "-------------------------------------------------...............edas-------------------------------------------------------------------------"  
fi                                                                                                                                                    
                                                                                                                                                      
echo "-------------------------------------------------- ......svc............ ----------------------------------------------------------------------"
                                                                                                                                                      
svc_count=$(sudo /usr/local/bin/kubectl --kubeconfig $kubeconfig get svc -n $namespace -l svc=$app|grep $app|wc -l)                                   
if [ "$svc_count" = 0 ]                                                                                                                               
then                                                                                                                                                  
  echo "-------------------------------------------------- svc........................------------------------------------------------------------------"
. ~/k8s/kube-script/jenkins-script/build-svc-moby.sh $app                                                                                                
else                                                                                                                                                     
  echo "----------------------------------------------------- svc......... -------------------------------------------------------------------------"    
fi                                                                                                                                                       
                                                                                                                                                         
#-----------------------------------------------------------------------------------------------------------------------------------------------#        
                                                                                                                                                         
else                                                                                                                                                     
                                                                                                                                                         
echo "----------------------------------------------- .........Deployment...$deployment_name --------------------------------------------------------"   
                                                                                                                                                         
old_img_num=$(sudo /usr/local/bin/kubectl --kubeconfig $kubeconfig describe deployment $deployment_name -n $namespace |grep Image|cut -d "_" -f2)        
if [ "$old_img_num" -lt 2 ]      
then                                                                                                                                                     
  new_img_num=$((old_img_num+1))                                                                                                                         
else                                                                                                                                                     
  new_img_num=1                                                                                                                                          
fi                                                                                                                                                       
                                                                                                                                                         
echo "----------------------------------------------------.................."$app"_"$new_img_num"-----------------------------------------------------"  
cd $workspace && sudo docker build -t $docker_repo:"$app"_"$new_img_num" .                                                                               
sudo docker push $docker_repo:"$app"_"$new_img_num"                                                                                                      
sudo docker rmi $docker_repo:"$app"_"$new_img_num"                                                                                                       
                                                                                                                                                         
echo "-----------------------------------------------------------......Deployment------------------------------------------------------------------"     
                                                                                                                                                         
sudo /usr/local/bin/kubectl --kubeconfig $kubeconfig set image deployment/$deployment_name -n $namespace \                                               
$deployment_name="$docker_repo":"$app"_"$new_img_num" --record=true                                                                                      
                                                                                                                                                         
fi                                                                                                                                                       
#=================================================================================================================================================#                                                                        