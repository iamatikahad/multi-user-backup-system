# AD Disaster Recovery

1. Backup system state
2. Restore using wbadmin
3. Reboot in DSRM mode
4. 
````markdown
Active Directory Disaster Recovery Guide (Windows Server)

This guide outlines how to backup and restore **Active Directory (AD)** using `wbadmin` and **Directory Services Restore Mode (DSRM)**.

---

 Step 1: Backup AD System State

Use `wbadmin` to create a System State backup. Run the following command in **Command Prompt (Admin)**:

```powershell
wbadmin start systemstatebackup -backupTarget:D: -quiet
````

> 📌 Ensure the backup target (D:) has sufficient space and Windows Server Backup feature is installed.

---

 Step 2: Reboot in DSRM Mode

To restore AD, reboot the server into **Directory Services Restore Mode (DSRM)**:

1. Restart the Domain Controller
2. Press `F8` or `Shift + F8` before Windows loads
3. Choose **Directory Services Restore Mode**

Or use `msconfig`:

```powershell
msconfig → Boot → Safe Boot → Active Directory Repair
```

---

 Step 3: Restore AD from Backup

Once in DSRM mode, restore the system state:

```powershell
wbadmin start systemstaterecovery -version:<version-identifier> -backupTarget:D: -quiet
```

> You can get the backup version using:
> `wbadmin get versions`

---

Step 4: Reboot and Sync

* For **Non-Authoritative Restore**, simply reboot → AD will sync from other DCs.
* For **Authoritative Restore**, use `ntdsutil` to mark objects as authoritative.

---

 Summary

| Task                    | Command                             |
| ----------------------- | ----------------------------------- |
| Backup System State     | `wbadmin start systemstatebackup`   |
| Reboot to DSRM          | F8 or `msconfig`                    |
| Restore AD              | `wbadmin start systemstaterecovery` |
| Optional: Authoritative | `ntdsutil`                          |

---

## 📁 Notes

* Ensure regular backups
* Store backup offsite/cloud
* Always test DR in a lab

```
