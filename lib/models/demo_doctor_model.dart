/// Demo doctor model for OPD booking flow
/// Contains all necessary fields for displaying doctor information and booking slots
class ConsultantType {
  final String id;
  final String name;
  final String imageUrl;
  final String description;

  const ConsultantType({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
  });
}

class Doctor {
  final String id;
  final String name;
  final String specialization;
  final String consultantTypeId;
  final String imageUrl;
  final double fees;
  final double rating;
  final String experience;
  final List<String> availableSlots;
  final String about;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.consultantTypeId,
    required this.imageUrl,
    required this.fees,
    required this.rating,
    required this.experience,
    required this.availableSlots,
    required this.about,
  });
}

class BookingSlot {
  final String time;
  final bool isAvailable;
  final String date;

  const BookingSlot({
    required this.time,
    required this.isAvailable,
    required this.date,
  });
}

class BookingInfo {
  final Doctor doctor;
  final String date;
  final String time;
  final double fees;
  final DateTime createdAt;

  const BookingInfo({
    required this.doctor,
    required this.date,
    required this.time,
    required this.fees,
    required this.createdAt,
  });
}

/// Demo data for consultant types
const List<ConsultantType> demoConsultantTypes = [
  ConsultantType(
    id: 'gp',
    name: 'General Physician',
    imageUrl: 'https://images.unsplash.com/photo-1559757148-5c350d0d3c56?w=400&h=300&fit=crop',
    description: 'General health checkups and common illnesses',
  ),
  ConsultantType(
    id: 'dentist',
    name: 'Dentist',
    imageUrl: 'https://images.unsplash.com/photo-1600950335869-484a82705d4e?w=400&h=300&fit=crop',
    description: 'Dental care and oral hygiene',
  ),
  ConsultantType(
    id: 'cardiologist',
    name: 'Cardiologist',
    imageUrl: 'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=400&h=300&fit=crop',
    description: 'Heart and cardiovascular diseases',
  ),
  ConsultantType(
    id: 'pediatrician',
    name: 'Pediatrician',
    imageUrl: 'https://images.unsplash.com/photo-1576091160550-2173dba999ef?w=400&h=300&fit=crop',
    description: 'Child healthcare and development',
  ),
  ConsultantType(
    id: 'orthopedic',
    name: 'Orthopedic',
    imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ab?w=400&h=300&fit=crop',
    description: 'Bone and joint disorders',
  ),
  ConsultantType(
    id: 'neurologist',
    name: 'Neurologist',
    imageUrl: 'https://images.unsplash.com/photo-1551190822-a353f8065841?w=400&h=300&fit=crop',
    description: 'Brain and nervous system disorders',
  ),
];

/// Demo data for doctors
const List<Doctor> demoDoctors = [
  // General Physicians
  Doctor(
    id: '1',
    name: 'Dr. Sarah Johnson',
    specialization: 'General Physician',
    consultantTypeId: 'gp',
    imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200&h=200&fit=crop&crop=face',
    fees: 500.0,
    rating: 4.8,
    experience: '15+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '03:00 PM', '04:00 PM'],
    about: 'Experienced general physician with expertise in preventive care and chronic disease management.',
  ),
  Doctor(
    id: '2',
    name: 'Dr. Michael Chen',
    specialization: 'General Physician',
    consultantTypeId: 'gp',
    imageUrl: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=200&h=200&fit=crop&crop=face',
    fees: 600.0,
    rating: 4.9,
    experience: '20+ years',
    availableSlots: ['08:00 AM', '09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '05:00 PM'],
    about: 'Senior physician specializing in internal medicine and geriatric care.',
  ),
  
  // Dentists
  Doctor(
    id: '3',
    name: 'Dr. Emily Rodriguez',
    specialization: 'Dentist',
    consultantTypeId: 'dentist',
    imageUrl: 'https://images.unsplash.com/photo-1594824475063-1b1b8b3b3b3b?w=200&h=200&fit=crop&crop=face',
    fees: 800.0,
    rating: 4.7,
    experience: '10+ years',
    availableSlots: ['10:00 AM', '11:00 AM', '12:00 PM', '02:00 PM', '03:00 PM', '04:00 PM'],
    about: 'Specialist in cosmetic dentistry and orthodontic treatments.',
  ),
  Doctor(
    id: '4',
    name: 'Dr. James Wilson',
    specialization: 'Dentist',
    consultantTypeId: 'dentist',
    imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200&h=200&fit=crop&crop=face',
    fees: 750.0,
    rating: 4.6,
    experience: '12+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '01:00 PM', '02:00 PM', '04:00 PM', '05:00 PM'],
    about: 'Expert in dental surgery and implantology with advanced training.',
  ),
  
  // Cardiologists
  Doctor(
    id: '5',
    name: 'Dr. Robert Martinez',
    specialization: 'Cardiologist',
    consultantTypeId: 'cardiologist',
    imageUrl: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=200&h=200&fit=crop&crop=face',
    fees: 1200.0,
    rating: 4.9,
    experience: '18+ years',
    availableSlots: ['08:00 AM', '09:00 AM', '11:00 AM', '02:00 PM', '03:00 PM', '04:00 PM'],
    about: 'Interventional cardiologist with expertise in complex cardiac procedures.',
  ),
  Doctor(
    id: '6',
    name: 'Dr. Lisa Anderson',
    specialization: 'Cardiologist',
    consultantTypeId: 'cardiologist',
    imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200&h=200&fit=crop&crop=face',
    fees: 1000.0,
    rating: 4.8,
    experience: '15+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '12:00 PM', '01:00 PM', '03:00 PM', '05:00 PM'],
    about: 'Specialist in preventive cardiology and heart failure management.',
  ),
  
  // Pediatricians
  Doctor(
    id: '7',
    name: 'Dr. Amanda Thompson',
    specialization: 'Pediatrician',
    consultantTypeId: 'pediatrician',
    imageUrl: 'https://images.unsplash.com/photo-1594824475063-1b1b8b3b3b3b?w=200&h=200&fit=crop&crop=face',
    fees: 700.0,
    rating: 4.9,
    experience: '12+ years',
    availableSlots: ['08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '03:00 PM'],
    about: 'Pediatric specialist with focus on child development and vaccinations.',
  ),
  Doctor(
    id: '8',
    name: 'Dr. David Kim',
    specialization: 'Pediatrician',
    consultantTypeId: 'pediatrician',
    imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200&h=200&fit=crop&crop=face',
    fees: 650.0,
    rating: 4.7,
    experience: '8+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '11:00 AM', '01:00 PM', '02:00 PM', '04:00 PM'],
    about: 'Expert in pediatric emergency care and childhood diseases.',
  ),
  
  // Orthopedic
  Doctor(
    id: '9',
    name: 'Dr. Christopher Lee',
    specialization: 'Orthopedic Surgeon',
    consultantTypeId: 'orthopedic',
    imageUrl: 'https://images.unsplash.com/photo-1582750433449-648ed127bb54?w=200&h=200&fit=crop&crop=face',
    fees: 1500.0,
    rating: 4.8,
    experience: '20+ years',
    availableSlots: ['08:00 AM', '10:00 AM', '11:00 AM', '02:00 PM', '04:00 PM', '05:00 PM'],
    about: 'Senior orthopedic surgeon specializing in joint replacement and sports injuries.',
  ),
  Doctor(
    id: '10',
    name: 'Dr. Michelle Brown',
    specialization: 'Orthopedic Surgeon',
    consultantTypeId: 'orthopedic',
    imageUrl: 'https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=200&h=200&fit=crop&crop=face',
    fees: 1300.0,
    rating: 4.7,
    experience: '14+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '12:00 PM', '01:00 PM', '03:00 PM', '04:00 PM'],
    about: 'Specialist in spine surgery and minimally invasive orthopedic procedures.',
  ),
  
  // Neurologists
  Doctor(
    id: '11',
    name: 'Dr. Jennifer Davis',
    specialization: 'Neurologist',
    consultantTypeId: 'neurologist',
    imageUrl: 'https://images.unsplash.com/photo-1594824475063-1b1b8b3b3b3b?w=200&h=200&fit=crop&crop=face',
    fees: 1400.0,
    rating: 4.9,
    experience: '16+ years',
    availableSlots: ['08:00 AM', '09:00 AM', '11:00 AM', '01:00 PM', '03:00 PM', '04:00 PM'],
    about: 'Expert in neurology with specialization in movement disorders and epilepsy.',
  ),
  Doctor(
    id: '12',
    name: 'Dr. Richard Garcia',
    specialization: 'Neurologist',
    consultantTypeId: 'neurologist',
    imageUrl: 'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?w=200&h=200&fit=crop&crop=face',
    fees: 1300.0,
    rating: 4.8,
    experience: '12+ years',
    availableSlots: ['09:00 AM', '10:00 AM', '12:00 PM', '02:00 PM', '03:00 PM', '05:00 PM'],
    about: 'Specialist in stroke management and neurocritical care.',
  ),
];

/// Demo time slots for booking
const List<String> demoTimeSlots = [
  '08:00 AM', '09:00 AM', '10:00 AM', '11:00 AM',
  '12:00 PM', '01:00 PM', '02:00 PM', '03:00 PM',
  '04:00 PM', '05:00 PM', '06:00 PM'
];
