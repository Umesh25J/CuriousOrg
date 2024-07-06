public class UserDeactivationQueueable implements Queueable, Database.AllowsCallouts {
    private List<User> usersToDeactivate;
    
    public UserDeactivationQueueable(List<User> usersToDeactivate) {
        this.usersToDeactivate = usersToDeactivate;
    }
    
    public void execute(QueueableContext context) {
        try {
            Database.update(usersToDeactivate);
        } catch (Exception e) {
            System.debug('Failed to update users: ' + e.getMessage());
        }
    }
}