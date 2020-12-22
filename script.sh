PS3='Choose From Main Menu : '
select option in 'Add User' 'Add Group' 'Remove User' 'Remove Group' 'Change Password' 'Test Login'
do
	if [[ $option == 'Add User' ]]
	then
		
		read -p 'Enter Username: ' uservar
		usrtemp=$(grep ^$uservar users)		
		if [[ -z $usrtemp ]]
		then
			read -p 'Enter Group name: ' grpvar
			grptemp=$(grep $grpvar group)
			if [[ -n $grptemp ]]
			then
				read -p 'Enter Password: ' passvar
				echo "$uservar:$grpvar:$passvar" >> users
				echo "User added successfully"
				
			else
				echo "Group Does not exist"
				read -p 'To add new group, Enter Groupname: ' grpvar
				echo "$grpvar" >> group
				echo "Group added successfully"
				read -p 'Enter User Password: ' passvar
				echo "$uservar:$grpvar:$passvar" >> users
				echo "User added successfully"
			fi
		else
			echo "User already exists"
			
		fi
		
				
		
	fi
	if [[ $option == 'Add Group' ]]
	then
		read -p 'Enter Group name: ' grpvar
			grptemp=$(grep $grpvar group)
			if [[ -z $grptemp ]]
			then
				
				echo "$grpvar" >> group
				echo "Group added successfully"
				
			else
				echo "Group already exist"
			fi
	fi
	if [[ $option == 'Remove User' ]]
	then
		read -p 'Enter Username: ' uservar
		sed -i "/$uservar/d" users
		echo "User removed succefully"
	fi
	if [[ $option == 'Remove Group' ]]
	then
		read -p 'Enter Groupname: ' grpvar	
		temp=$(grep $grpvar group)
		if [[ -n $temp ]]
		then	
			temp=$(grep $grpvar users)	
			if [[ -n $temp ]]
			then
				echo "Can't remove a group that has users"
			else
				sed -i "/$grpvar/d" group
				echo "Group removed succefully"
			fi
		else
			echo "No such group"
		fi
	fi
	if [[ $option == 'Change Password' ]]
	then
		read -p 'Enter Username: ' uservar
		temp=$(grep $uservar users)
		if [[ -n $temp ]]
		then
			read -p 'Enter old password: ' oldpassvar
			read -p 'Enter new password: ' passvar
			sed -i -e "/$uservar/s/$oldpassvar/$passvar/" users
			echo "password changed successfuly"
		
		fi	
	
	fi
	if [[ $option == 'Test Login' ]]
	then
		read -p 'Enter Username: ' uservar
		temp=$(grep $uservar users)
		if [[ -n $temp ]]
		then
			read -p 'Enter Password: ' passvar
			temp=$(grep ^$uservar users| awk -F':' '{ print $3 }')
			if [[ $passvar == $temp ]]
			then

				echo "You are logged in"
			else
				echo "Invalid Passowrd"
			fi
			
		else
			echo "No such user"
		fi
	fi
	
done
