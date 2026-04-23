// ===== USER =====
class User {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String rank;
  final double rankProgress; // 0..1
  final int points;
  final String memberCode;
  final DateTime joinedAt;

  const User({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.rank,
    required this.rankProgress,
    required this.points,
    required this.memberCode,
    required this.joinedAt,
  });
}

// ===== REWARD =====
class Reward {
  final String id;
  final String name;
  final String category;
  final int points;
  final String image;
  final int stock;
  final String description;

  const Reward({
    required this.id,
    required this.name,
    required this.category,
    required this.points,
    required this.image,
    required this.stock,
    required this.description,
  });
}

// ===== NEWS =====
class NewsItem {
  final String id;
  final String title;
  final String excerpt;
  final DateTime date;
  final String category;
  final String image;
  final String body;

  const NewsItem({
    required this.id,
    required this.title,
    required this.excerpt,
    required this.date,
    required this.category,
    required this.image,
    required this.body,
  });
}

// ===== VOUCHER =====
enum VoucherStatus { available, used, expired }
enum VoucherType { discount, gift, shipping }

class Voucher {
  final String id;
  final String title;
  final String code;
  final String discount;
  final DateTime expiresAt;
  final VoucherStatus status;
  final VoucherType type;

  const Voucher({
    required this.id,
    required this.title,
    required this.code,
    required this.discount,
    required this.expiresAt,
    required this.status,
    required this.type,
  });
}

// ===== BRANCH =====
class Branch {
  final String id, name, address, phone, hours;
  final double distanceKm;
  const Branch({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.hours,
    required this.distanceKm,
  });
}

// ===== NOTIFICATION =====
enum NotificationType { promo, system, reward }

class AppNotification {
  final String id, title, message, time;
  final NotificationType type;
  final bool unread;
  const AppNotification({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.unread,
  });
}

// ===== HANDBOOK NOTE =====
class HandbookNote {
  final String id, title, content;
  final DateTime createdAt;
  const HandbookNote({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });
}

// ===== SUPPORT TICKET =====
enum SupportStatus { open, processing, closed }

class SupportTicket {
  final String id, title, content;
  final String? image;
  final SupportStatus status;
  final String createdAt;
  const SupportTicket({
    required this.id,
    required this.title,
    required this.content,
    this.image,
    required this.status,
    required this.createdAt,
  });
}

// ===== POINT TRANSACTION =====
enum PointTxType { earn, redeem, transferIn, transferOut, checkin }

class PointTransaction {
  final String id, title, description, date;
  final PointTxType type;
  final int amount; // signed
  final String? ref;
  const PointTransaction({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.amount,
    required this.date,
    this.ref,
  });
}

// ===== PRODUCT (scan result) =====
class Product {
  final String code, name, category, image, manufacturer, origin, warranty, description;
  final List<String> certifications;
  final int pointsOnScan;
  const Product({
    required this.code,
    required this.name,
    required this.category,
    required this.image,
    required this.manufacturer,
    required this.origin,
    required this.warranty,
    required this.certifications,
    required this.description,
    required this.pointsOnScan,
  });
}

// ===== CHECKIN =====
class CheckinDay {
  final String day;
  final int reward;
  final bool claimed;
  final bool today;
  const CheckinDay({
    required this.day,
    required this.reward,
    required this.claimed,
    this.today = false,
  });

  CheckinDay copyWith({String? day, int? reward, bool? claimed, bool? today}) {
    return CheckinDay(
      day: day ?? this.day,
      reward: reward ?? this.reward,
      claimed: claimed ?? this.claimed,
      today: today ?? this.today,
    );
  }
}

// ===== WHEEL PRIZE =====
class WheelPrize {
  final String label;
  final int color; // ARGB int
  const WheelPrize({required this.label, required this.color});
}

// =====================================================
// MOCK DATA
// =====================================================

final User mockCurrentUser = User(
  id: 'u-001',
  name: 'Nguyễn Minh Khoa',
  phone: '0901 234 567',
  email: 'khoa.nm@example.com',
  rank: 'Đối tác Vàng',
  rankProgress: 0.62,
  points: 12480,
  memberCode: 'TPECO-2024-0001',
  joinedAt: DateTime(2024, 3, 12),
);

final List<Reward> mockRewards = [
  const Reward(
    id: 'r-01',
    name: 'Dây cáp đồng Trần Phú 2.5mm',
    category: 'Sản phẩm',
    points: 1500,
    image: 'https://images.unsplash.com/photo-1581092334651-ddf26d9a09d0?auto=format&fit=crop&w=600&q=70',
    stock: 24,
    description: 'Cuộn dây cáp đồng cao cấp 100m, đạt chuẩn ISO 9001.',
  ),
  const Reward(
    id: 'r-02',
    name: 'Bộ ổ cắm thông minh',
    category: 'Thiết bị',
    points: 2400,
    image: 'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=600&q=70',
    stock: 18,
    description: 'Ổ cắm điện thông minh 4 cổng tích hợp chống giật.',
  ),
  const Reward(
    id: 'r-03',
    name: 'Voucher mua hàng 200K',
    category: 'Voucher',
    points: 800,
    image: 'https://images.unsplash.com/photo-1556742400-b5b7c5121f2d?auto=format&fit=crop&w=600&q=70',
    stock: 100,
    description: 'Áp dụng cho đơn hàng từ 1.000.000đ tại hệ thống Trần Phú.',
  ),
  const Reward(
    id: 'r-04',
    name: 'Áo thun ECOTP',
    category: 'Quà tặng',
    points: 600,
    image: 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=600&q=70',
    stock: 50,
    description: 'Áo thun cotton in logo ECOTP phiên bản giới hạn.',
  ),
  const Reward(
    id: 'r-05',
    name: 'Bình giữ nhiệt 500ml',
    category: 'Quà tặng',
    points: 950,
    image: 'https://images.unsplash.com/photo-1602143407151-7111542de6e8?auto=format&fit=crop&w=600&q=70',
    stock: 35,
    description: 'Bình giữ nhiệt inox cao cấp khắc logo Trần Phú.',
  ),
  const Reward(
    id: 'r-06',
    name: 'Combo dụng cụ điện',
    category: 'Sản phẩm',
    points: 3200,
    image: 'https://images.unsplash.com/photo-1581092580497-e0d23cbdf1dc?auto=format&fit=crop&w=600&q=70',
    stock: 12,
    description: 'Bộ dụng cụ điện chuyên dụng cho thợ kỹ thuật.',
  ),
];

final List<NewsItem> mockNews = [
  NewsItem(
    id: 'n-01',
    title: 'Ra mắt dây cáp điện thế hệ mới ECOTP Pro',
    excerpt: 'Trần Phú giới thiệu dòng cáp điện cao cấp với công nghệ chống cháy tiên tiến...',
    date: DateTime(2024, 6, 15),
    category: 'Sản phẩm mới',
    image: 'https://images.unsplash.com/photo-1621905252507-b35492cc74b4?auto=format&fit=crop&w=800&q=70',
    body: 'Trần Phú vừa chính thức ra mắt dòng cáp điện thế hệ mới ECOTP Pro...',
  ),
  NewsItem(
    id: 'n-02',
    title: 'Chương trình tri ân khách hàng Quý 3/2024',
    excerpt: 'Nhân dịp kỷ niệm 20 năm thành lập, Trần Phú tung chương trình ưu đãi lớn...',
    date: DateTime(2024, 7, 1),
    category: 'Khuyến mãi',
    image: 'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=800&q=70',
    body: 'Nhân kỷ niệm 20 năm thành lập, Trần Phú dành tặng khách hàng thân thiết...',
  ),
  NewsItem(
    id: 'n-03',
    title: 'Trần Phú đạt chứng nhận ISO 14001:2015',
    excerpt: 'Khẳng định cam kết phát triển bền vững và bảo vệ môi trường...',
    date: DateTime(2024, 5, 20),
    category: 'Tin tức',
    image: 'https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=70',
    body: 'Trần Phú tự hào thông báo đã chính thức đạt chứng nhận ISO 14001:2015...',
  ),
];

final List<Voucher> mockVouchers = [
  Voucher(
    id: 'v-01',
    title: 'Giảm 10% đơn hàng',
    code: 'TP10OFF',
    discount: '10%',
    expiresAt: DateTime(2024, 12, 31),
    status: VoucherStatus.available,
    type: VoucherType.discount,
  ),
  Voucher(
    id: 'v-02',
    title: 'Miễn phí vận chuyển',
    code: 'FREESHIP',
    discount: 'Free ship',
    expiresAt: DateTime(2024, 11, 30),
    status: VoucherStatus.available,
    type: VoucherType.shipping,
  ),
  Voucher(
    id: 'v-03',
    title: 'Tặng áo thun ECOTP',
    code: 'GIFTTEE',
    discount: 'Quà tặng',
    expiresAt: DateTime(2024, 6, 30),
    status: VoucherStatus.used,
    type: VoucherType.gift,
  ),
  Voucher(
    id: 'v-04',
    title: 'Giảm 50K cho đơn 500K',
    code: 'TP50K',
    discount: '50.000đ',
    expiresAt: DateTime(2024, 3, 31),
    status: VoucherStatus.expired,
    type: VoucherType.discount,
  ),
];

const List<Branch> mockBranches = [
  Branch(id: 'b-01', name: 'Chi nhánh Quận 1', address: '123 Nguyễn Huệ, P. Bến Nghé, Q.1, TP.HCM', phone: '028 3821 0001', hours: '08:00 - 17:30', distanceKm: 1.2),
  Branch(id: 'b-02', name: 'Chi nhánh Quận 7', address: '456 Nguyễn Thị Thập, P. Tân Phú, Q.7, TP.HCM', phone: '028 3773 0002', hours: '08:00 - 17:30', distanceKm: 5.8),
  Branch(id: 'b-03', name: 'Chi nhánh Bình Thạnh', address: '789 Điện Biên Phủ, P.22, Q. Bình Thạnh, TP.HCM', phone: '028 3512 0003', hours: '08:00 - 18:00', distanceKm: 3.4),
  Branch(id: 'b-04', name: 'Chi nhánh Hà Nội', address: '321 Phố Huế, Q. Hai Bà Trưng, Hà Nội', phone: '024 3971 0004', hours: '08:00 - 17:30', distanceKm: 1200),
];

const List<AppNotification> mockNotifications = [
  AppNotification(id: 'nt-01', title: 'Bạn vừa nhận 150 điểm!', message: 'Quét sản phẩm thành công. Tổng điểm hiện tại: 12.480.', time: '2 phút trước', type: NotificationType.reward, unread: true),
  AppNotification(id: 'nt-02', title: 'Flash Sale cuối tuần', message: 'Giảm 20% khi đổi điểm phần thưởng. Chỉ trong 48h!', time: '1 giờ trước', type: NotificationType.promo, unread: true),
  AppNotification(id: 'nt-03', title: 'Cập nhật ứng dụng', message: 'Phiên bản mới 2.1 đã sẵn sàng với nhiều cải tiến.', time: '1 ngày trước', type: NotificationType.system, unread: false),
  AppNotification(id: 'nt-04', title: 'Voucher sắp hết hạn', message: 'Voucher "Giảm 10% đơn hàng" hết hạn trong 3 ngày.', time: '2 ngày trước', type: NotificationType.promo, unread: false),
];

final List<HandbookNote> mockHandbookNotes = [
  HandbookNote(id: 'hb-01', title: 'Cách chọn dây điện phù hợp', content: 'Khi chọn dây điện cần xem xét tiết diện, chất liệu lõi đồng, lớp cách điện...', createdAt: DateTime(2024, 6, 10)),
  HandbookNote(id: 'hb-02', title: 'Bảo trì hệ thống điện định kỳ', content: 'Nên kiểm tra hệ thống điện 6 tháng/lần để đảm bảo an toàn...', createdAt: DateTime(2024, 5, 25)),
  HandbookNote(id: 'hb-03', title: 'Tiêu chuẩn an toàn TCVN', content: 'Các tiêu chuẩn TCVN áp dụng cho dây và cáp điện...', createdAt: DateTime(2024, 4, 15)),
];

const List<SupportTicket> mockSupportTickets = [
  SupportTicket(id: 'st-01', title: 'Không quét được mã QR', content: 'Tôi thử quét mã QR trên sản phẩm nhưng app báo lỗi không nhận diện được...', status: SupportStatus.processing, createdAt: '15/06/2024'),
  SupportTicket(id: 'st-02', title: 'Đổi điểm nhưng chưa nhận voucher', content: 'Tôi đã đổi 800 điểm lấy voucher nhưng chưa thấy xuất hiện trong ví...', status: SupportStatus.open, createdAt: '12/06/2024'),
  SupportTicket(id: 'st-03', title: 'Yêu cầu đổi thông tin tài khoản', content: 'Tôi muốn cập nhật lại số điện thoại đăng ký...', status: SupportStatus.closed, createdAt: '01/06/2024'),
];

const List<PointTransaction> mockPointTransactions = [
  PointTransaction(id: 'pt-01', type: PointTxType.earn, title: 'Quét sản phẩm', description: 'Dây cáp đồng TP 2.5mm', amount: 150, date: '23/06/2024'),
  PointTransaction(id: 'pt-02', type: PointTxType.redeem, title: 'Đổi voucher', description: 'Voucher mua hàng 200K', amount: -800, date: '20/06/2024'),
  PointTransaction(id: 'pt-03', type: PointTxType.checkin, title: 'Điểm danh', description: 'Ngày 5 liên tiếp', amount: 50, date: '19/06/2024'),
  PointTransaction(id: 'pt-04', type: PointTxType.transferOut, title: 'Chuyển điểm', description: 'Đến Nguyễn Văn An', amount: -200, date: '15/06/2024'),
  PointTransaction(id: 'pt-05', type: PointTxType.earn, title: 'Quét sản phẩm', description: 'Bộ ổ cắm thông minh', amount: 300, date: '10/06/2024'),
  PointTransaction(id: 'pt-06', type: PointTxType.transferIn, title: 'Nhận điểm', description: 'Từ Trần Minh Tuấn', amount: 500, date: '05/06/2024'),
];

const Product mockScannedProduct = Product(
  code: 'TP-ECO-2024-001',
  name: 'Dây cáp đồng Trần Phú 2.5mm ECOTP',
  category: 'Dây & Cáp điện',
  image: 'https://images.unsplash.com/photo-1581092334651-ddf26d9a09d0?auto=format&fit=crop&w=600&q=70',
  manufacturer: 'Công ty CP Cáp điện Trần Phú',
  origin: 'Việt Nam',
  warranty: '12 tháng',
  certifications: ['ISO 9001:2015', 'TCVN 6610-3', 'IEC 60227'],
  description: 'Dây cáp đồng cao cấp 100m, lõi đồng nguyên chất 99.97%, cách điện PVC chống cháy.',
  pointsOnScan: 150,
);

const List<CheckinDay> mockCheckinWeek = [
  CheckinDay(day: 'T2', reward: 10, claimed: true),
  CheckinDay(day: 'T3', reward: 10, claimed: true),
  CheckinDay(day: 'T4', reward: 15, claimed: true),
  CheckinDay(day: 'T5', reward: 15, claimed: true),
  CheckinDay(day: 'T6', reward: 20, claimed: false, today: true),
  CheckinDay(day: 'T7', reward: 25, claimed: false),
  CheckinDay(day: 'CN', reward: 50, claimed: false),
];

const List<WheelPrize> mockWheelPrizes = [
  WheelPrize(label: '50 điểm', color: 0xFFD22A2D),
  WheelPrize(label: '100 điểm', color: 0xFFE8CC6A),
  WheelPrize(label: 'Voucher 50K', color: 0xFF1B2238),
  WheelPrize(label: '20 điểm', color: 0xFFD08F4E),
  WheelPrize(label: '200 điểm', color: 0xFFD22A2D),
  WheelPrize(label: 'Áo thun', color: 0xFFE8CC6A),
  WheelPrize(label: '10 điểm', color: 0xFF1B2238),
  WheelPrize(label: 'Voucher 100K', color: 0xFFD08F4E),
];
