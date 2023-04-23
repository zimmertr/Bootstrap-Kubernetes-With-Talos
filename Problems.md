Commented out VM parameters
Fix node destroy cordon/drain/delete/etcd remove
Replace "Wait for the control plane nodes to be ready" task with proper query instead of sleep
Can any tasks be made async for performance boost?
Figure out upgrades
Audit Telmate parameters. Should we emulate SSD for disk for example?
Fix multi-cluster
    - Terraform state files need to be managed spearately, different dirs?
Node add/remove is broken, perhaps becuase joining manage_template roles?
manage_addons role won't execute for new nodes, which means they won't have DiskPool resources created
Try managing two clusters at once
    - Create one
    - Create two
    - Delete one
    - Expand two
    - Create three
    - Shrink two
    - Expand three
    - Delete three
