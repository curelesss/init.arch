echo -*********************************-
echo -** Run Ansible Init Play-book  **-
echo -*********************************-

ansible-playbook book_-.yml --ask-become-pass --ask-vault-pass -vv

echo -*********************************-
echo -** Set current repo to ssh     **-
echo -*********************************-

git remote set-url origin git@github.com:curelesss/init.ubuntu.git

echo -*********************************-
echo -** Testing Github Connection   **-
echo -*********************************-

ssh -T git@github.com
