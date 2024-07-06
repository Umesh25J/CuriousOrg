import { LightningElement, track } from 'lwc';

export default class ContactList extends LightningElement {
    @track contacts = [
        { id: 1, name: 'Alice Smith', phone: '555-123-4567', email: 'alice@example.com' },
        { id: 2, name: 'Bob Johnson', phone: '555-987-6543', email: 'bob@example.com' },
        { id: 3, name: 'Alice Smith', phone: '555-456-7890', email: 'alice2@example.com' },
        { id: 4, name: 'Charlie Williams', phone: '555-222-3333', email: 'charlie@example.com' },
        { id: 5, name: 'Bob Johnson', phone: '555-444-2222', email: 'bob2@example.com' }
    ];

    get groupedContacts() {
        // Create a map to store the contacts grouped by name
        const groupedContactsMap = new Map();

        // Iterate over the contacts array
        for (const contact of this.contacts) {
            // If the map doesn't have an entry for the current contact's name,
            // create a new entry with an empty array as the value
            if (!groupedContactsMap.has(contact.name)) {
                groupedContactsMap.set(contact.name, []);
            }

            // Push the current contact into the array for the corresponding name
            groupedContactsMap.get(contact.name).push(contact);
        }

        // Convert the map to an array of objects with name and contacts properties
        return Array.from(groupedContactsMap.entries()).map(([name, contacts]) => ({ name, contacts }));
    }
}