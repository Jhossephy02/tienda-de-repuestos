/**
 * MotoStock Pro 2026 - UI Components Logic
 * Handles animations and interactive elements
 */

document.addEventListener('DOMContentLoaded', () => {
    console.log('MotoStock Pro 2026 - Initialized');
    
    // Smooth reveal for elements
    const observerOptions = {
        threshold: 0.1
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('animate-fade-in');
            }
        });
    }, observerOptions);

    document.querySelectorAll('.reveal').forEach(el => observer.observe(el));
});
