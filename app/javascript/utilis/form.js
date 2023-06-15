document.addEventListener('DOMContentLoaded', () => {
  const form = document.getElementById('image-upload-form');
  const input = document.getElementById('image-input');

  // Prevent default behavior for drag events
  form.addEventListener('dragenter', (event) => {
    event.preventDefault();
  });
  form.addEventListener('dragover', (event) => {
    event.preventDefault();
  });
  form.addEventListener('dragleave', (event) => {
    event.preventDefault();
  });

  // Handle the dropped file
  form.addEventListener('drop', (event) => {
    event.preventDefault();

    // Get the dropped file
    const file = event.dataTransfer.files[0];

    // Set the dropped file as the form field value
    input.files = event.dataTransfer.files;
  });
});
