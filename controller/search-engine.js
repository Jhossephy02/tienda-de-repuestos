/**
 * MotoStock Pro 2026 - Search Engine
 * Optimizes product search and filtering
 */

class SearchEngine {
    constructor(products) {
        this.products = products;
    }

    find(query) {
        const lowerQuery = query.toLowerCase();
        return this.products.filter(p => 
            p.nombre.toLowerCase().includes(lowerQuery) || 
            p.codigo.toLowerCase().includes(lowerQuery) ||
            p.marca.toLowerCase().includes(lowerQuery)
        );
    }

    filterByCategory(category) {
        return this.products.filter(p => p.categoria === category);
    }
}

// Example usage
const engine = new SearchEngine([
    { id: 1, codigo: 'HND-01', nombre: 'Kit Arrastre', marca: 'Honda', categoria: 'Transmisión' },
    { id: 2, codigo: 'BJJ-02', nombre: 'Bujía Iridium', marca: 'Bajaj', categoria: 'Motor' }
]);
