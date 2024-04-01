// Sample data for the donut chart
const riderUtilizationData = [
    { label: 'Utilized', value: 90 },
    { label: 'Not Utilized', value: 10 }
  ];
  
  // Render the donut chart using D3.js
  const svg = d3.select('#riderUtilizationChart')
    .append('svg')
    .attr('width', '100%')
    .attr('height', '100%');
  
  // Add D3.js code to render the donut chart using the riderUtilizationData