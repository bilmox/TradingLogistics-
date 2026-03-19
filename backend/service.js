const express = require('express');
const nodemailer = require('nodemailer');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(express.json());

// Configure your email transporter
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER, // Your email
    pass: process.env.EMAIL_PASS, // Your App Password (not your login password)
  },
});

app.post('/api/inquiry', async (req, res) => {
  const { name, contact, service, requirements } = req.body;

  const mailOptions = {
    from: process.env.EMAIL_USER,
    to: 'info@TL-Oman.com', // Where you want to receive inquiries
    subject: `New Project Inquiry: ${service}`,
    html: `
      <h3>New Inquiry Details</h3>
      <p><b>Name:</b> ${name}</p>
      <p><b>Contact:</b> ${contact}</p>
      <p><b>Service:</b> ${service}</p>
      <p><b>Requirements:</b> ${requirements}</p>
    `,
  };

  try {
    await transporter.sendMail(mailOptions);
    res.status(200).json({ message: 'Inquiry sent successfully!' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Failed to send inquiry.' });
  }
});

app.listen(3000, () => console.log('Server running on port 3000'));