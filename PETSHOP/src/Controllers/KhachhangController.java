package Controllers;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.transaction.Transactional;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import Bean.Report;
import Bean.UserLogin;
import Entity.GioHang;
import Entity.KhachHang;
import Entity.NhanVien;
import Entity.NhomSanPham;
import Entity.SanPham;
import Entity.TaiKhoan;
import Entity.TinTuc;



@Transactional
@Controller
@RequestMapping("/user/")
public class KhachhangController {
	@Autowired
	SessionFactory factory;

	public void run(ModelMap model) {
		checkPQ(model);
		CountSL(model);
	}
	public boolean checkDN() {
		if (UserLogin.tenDangNhap.equals("none")) {
			return false;
		}
		return true;
	}
	public KhachHang layKH(String tdn) {
		KhachHang kh = new KhachHang();
		try {
			Session session = factory.getCurrentSession();
			String hql = "FROM KhachHang kh where kh.taiKhoan2.TenDangNhap =:tdn";
			Query query = session.createQuery(hql);
			query.setParameter("tdn", tdn);
			kh = (KhachHang) query.list().get(0);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kh;
	}

	public void CountSL(ModelMap model) {
		if (checkDN()==true) {
			KhachHang kh = layKH(UserLogin.tenDangNhap);
			int soLuong = 0;
			for (GioHang i : kh.getGioHang()) {
				soLuong = soLuong + i.getSoLuong();
			}
			model.addAttribute("hienThi", "block");
			model.addAttribute("soLuong", soLuong);
		}
		else model.addAttribute("hienThi", "none");
	}
	
	@ModelAttribute("nhomspm")
	public List<NhomSanPham> layNhomSPM(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM NhomSanPham where VatNuoi =:vn";
		Query query = session.createQuery(hql);
		query.setParameter("vn", "M??o");
		List<NhomSanPham> list = query.list();
		return list;
	}

	@ModelAttribute("nhomspc")
	public List<NhomSanPham> layNhomSPC(ModelMap model) {
		Session session = factory.getCurrentSession();
		String hql = "FROM NhomSanPham where VatNuoi =:vn";
		Query query = session.createQuery(hql);
		query.setParameter("vn", "Ch??");
		List<NhomSanPham> list = query.list();
		return list;
	}

	public void ShowReport(ModelMap model){
		model.addAttribute("tbTonTai",Report.tbTonTai);
		model.addAttribute("tbThanhCong",Report.tbThanhCong);
		model.addAttribute("tbThatBai",Report.tbThatBai);
	}
	
	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String logIn(ModelMap model) {
		UserLogin.tenDangNhap = "none";
		UserLogin.matKhau = "";
		UserLogin.ten = "";
		run(model);
		model.addAttribute("taikhoan", new TaiKhoan());
		return "user/login";
	}

	public String layTenKH(String tk, String mk) {
		KhachHang kh = new KhachHang();
		try {
			Session session = factory.getCurrentSession();
			String hql = "FROM KhachHang kh where kh.taiKhoan2.TenDangNhap =:tk and kh.taiKhoan2.MatKhau =:mk";
			Query query = session.createQuery(hql);
			query.setParameter("tk", tk);
			query.setParameter("mk", mk);
			kh = (KhachHang) query.list().get(0);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return kh.getTenKH();
	}

	public String layTenAD(String tk, String mk) {
		NhanVien nv = new NhanVien();
		try {
			Session session = factory.getCurrentSession();
			String hql = "FROM NhanVien nv where nv.TaiKhoan.TenDangNhap =:tk and nv.TaiKhoan.MatKhau =:mk";
			Query query = session.createQuery(hql);
			query.setParameter("tk", tk);
			query.setParameter("mk", mk);
			nv = (NhanVien) query.list().get(0);
			System.out.println(nv.getCMND());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return nv.getHoTen();
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String logIn(ModelMap model, @ModelAttribute("taikhoan") TaiKhoan taikhoan) {
		run(model);
		boolean check = true;
		if (taikhoan.getTenDangNhap().trim().isEmpty()) {
			check = false;
			model.addAttribute("LoiDinhDangTenDangNhap", "T??n ????ng nh???p kh??ng ???????c ????? tr???ng !");
		}

		// ki??????m tra ????????????nh d??????ng m??????t kh??????u kh????ng ????t h????n 8 k???? t???? v???? m??????t kh??????u kh????ng
		// ch?????? kho??????ng tr??????ng
		if (taikhoan.getMatKhau().trim().isEmpty()) {
			check = false;
			model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ???????c ????? tr???ng !");
		} else if (taikhoan.getMatKhau().trim().contains(" ")) {
			check = false;
			model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ch???a kho???ng tr???ng !");
		} else if (!taikhoan.getMatKhau().trim().matches(".{8,}")) {
			check = false;
			model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng d?????i 8 k?? t??? !");
		}

		if (check) {
			// ki??????m tra s?????? t???????n t??????i c??????a email trong c???? s?????? d?????? li????u
			try {
				Session session = factory.getCurrentSession();
				String hql = "FROM TaiKhoan tk where tk.TenDangNhap =:t and tk.MatKhau= :mk";
				Query query = session.createQuery(hql);
				query.setParameter("t", taikhoan.getTenDangNhap());
				query.setParameter("mk", taikhoan.getMatKhau());

				TaiKhoan user1 = (TaiKhoan) query.list().get(0);
				if (user1.isTrangThai() == true) {
					
					if (!(user1.getTenDangNhap().isEmpty()) && user1.getVaiTro().equals("Kh??ch h??ng")) {
						String tenKH = layTenKH(user1.getTenDangNhap(), user1.getMatKhau());
						String mangTen[] = tenKH.split(" ");

						UserLogin.tenDangNhap = user1.getTenDangNhap() + "";
						UserLogin.matKhau = user1.getMatKhau();
						UserLogin.ten = mangTen[mangTen.length - 1];

						System.out.println("user: " + UserLogin.tenDangNhap);
						System.out.println("mk: " + UserLogin.matKhau);
						System.out.println("ten: " + UserLogin.ten);
						return "redirect:/user/index1.htm";
					} else {
						String tenAD = layTenAD(user1.getTenDangNhap(), user1.getMatKhau());
						String mangTen[] = tenAD.split(" ");
						UserLogin.tenDangNhap = user1.getTenDangNhap() + "";
						UserLogin.matKhau = user1.getMatKhau();
						UserLogin.ten = mangTen[mangTen.length - 1];

						System.out.println("user: "+UserLogin.tenDangNhap);
						System.out.println("mk: "+UserLogin.matKhau);
						System.out.println("ten: "+UserLogin.ten);
						return "redirect:/hoadon.htm";
					}
				} else
					model.addAttribute("message", "T??i kho???n ???? b??? v?? hi???u ho?? !");
			} catch (Exception e) {
				// TODO: handle exception
				model.addAttribute("message", "T??i kho???n v?? m???t kh???u kh??ng ch??nh x??c !");
			}
		}
		return "user/login";
	}

	@RequestMapping("index1")
	public String index(ModelMap model) {
		run(model);
		Session session = factory.getCurrentSession();
		String hql = "FROM SanPham ORDER BY NEWID()";
		String hq2 = "FROM SanPham sp ORDER BY sp.MaSP DESC";
		Query query = session.createQuery(hql);
		Query query2 = session.createQuery(hq2);
		SanPham spnew = (SanPham) query2.list().get(0);
		List<SanPham> list = new ArrayList();
		for(int i = 0 ; i<8 ; i++){
			list.add((SanPham) query.list().get(i));
		}
		model.addAttribute("list",list);
		model.addAttribute("spnew",spnew);
		return "user/index";
	}

	@RequestMapping("dangxuat")
	public String dangXuat() {
		UserLogin.clear();
		System.out.println("user: " + UserLogin.tenDangNhap);
		System.out.println("mk: " + UserLogin.matKhau);
		System.out.println("ten: " + UserLogin.ten);
		return "redirect:/user/index1.htm";
	}

	@RequestMapping(value = "register", method = RequestMethod.GET)
	public String register(ModelMap model) {
		UserLogin.tenDangNhap = "none";
		UserLogin.matKhau = "";
		UserLogin.ten = "";
		run(model);
		model.addAttribute("khachhang", new KhachHang());
		return "user/register";
	}

	@RequestMapping(value = "register", method = RequestMethod.POST)
	public String register(ModelMap model, @ModelAttribute("khachhang") KhachHang khachhang) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		run(model);
		try {
			// bi??????n ki??????m tra validate
			boolean check = true;

			// ki??????m tra ????????????nh d??????ng c??????a t????n kh????ng ???????????????c c???? s???????
			if (khachhang.getTenKH().trim().equals("")) {
				check = false;
				model.addAttribute("LoiDinhDangTen", "T??n kh??ch h??ng kh??ng ???????c ????? tr???ng !");
			} else if (!khachhang.getTenKH().trim().matches("\\D+")) {
				check = false;
				model.addAttribute("LoiDinhDangTen", "T??n kh??ch h??ng kh??ng h???p l??? !");
			}

			// ki??????m tra s??????? ?????i???????n tho??????i kh????ng c???? k???? t?????? ch?????? v???? ???????????? d????i l???? 10 s???????
			if (khachhang.getSdt().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i kh??ng ???????c ????? tr???ng !");
			} else if (!khachhang.getSdt().trim().matches("\\d{10}")) {
				check = false;
				model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i kh??ng h???p l??? !");
			} else {
				// ki??????m tra s?????? t???????n t??????i c??????a sdt trong c???? s?????? d?????? li????u
				try {
					String hql = "FROM KhachHang where Sdt =:s";
					Query query = session.createQuery(hql);
					query.setParameter("s", khachhang.getSdt());
					List<KhachHang> list = query.list();
					if (!list.isEmpty()) {
						check = false;
						model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i n??y ???? t???n t???i !");
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}

			// ki??????m tra ????????????a ch??????? kh????ng ???????????????c b????? tr???????ng
			if (khachhang.getDiaChi().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangDiaChi", "?????a ch??? kh??ng ???????c ????? tr???ng !");
			}

			// ki??????m tra ????????????nh d??????ng email : abc@gmail.com.vn
			if (khachhang.getEmail().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangEmail", "Email kh??ng ???????c ????? tr???ng !");
			}
			// ki??????m tra ????????????nh d??????ng mail b??????ng regex
			else if (!khachhang.getEmail().trim().matches("\\w+@\\w+(\\.\\w+)+")) {
				check = false;
				model.addAttribute("LoiDinhDangEmail", "Email kh??ng h???p l??? !");
			} else {
				// ki??????m tra s?????? t???????n t??????i c??????a email trong c???? s?????? d?????? li????u
				try {
					String hql = "FROM KhachHang where Email =:email";
					Query query = session.createQuery(hql);
					query.setParameter("email", khachhang.getEmail());
					List<KhachHang> list = query.list();
					if (!list.isEmpty()) {
						check = false;
						model.addAttribute("LoiDinhDangEmail", "?????a ch??? Email ???? t???n t???i !");
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}

			if (khachhang.getTaiKhoan2().getTenDangNhap().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangTenDangNhap", "T??n ????ng nh???p kh??ng ???????c ????? tr???ng !");
			} else {
				// ki??????m tra s?????? t???????n t??????i c??????a t????n ?????????ng nh??????p trong c???? s?????? d?????? li????u
				try {
					String hql = "FROM TaiKhoan tk where tk.TenDangNhap =:tdn";
					Query query = session.createQuery(hql);
					query.setParameter("tdn", khachhang.getTaiKhoan2().getTenDangNhap());
					List<TaiKhoan> list = query.list();
					if (!list.isEmpty()) {
						check = false;
						model.addAttribute("LoiDinhDangTenDangNhap", "T??n ????ng nh???p n??y ???? t???n t???i !");
					}
				} catch (Exception e) {
					// TODO: handle exception
				}

			}
			if (khachhang.getTaiKhoan2().getMatKhau().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ???????c ????? tr???ng !");
			} else if (khachhang.getTaiKhoan2().getMatKhau().trim().contains(" ")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ch???a kho???ng tr???ng !");
			} else if (!khachhang.getTaiKhoan2().getMatKhau().trim().matches(".{8,}")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng d?????i 8 k?? t??? !");
			}
			if (check) {
				khachhang.getTaiKhoan2().setMatKhau(khachhang.getTaiKhoan2().getMatKhau().toLowerCase()); // chuy??????n m??????t kh??????u th????nh ch?????? th?????????ng
				khachhang.getTaiKhoan2().setTrangThai(true);
				khachhang.getTaiKhoan2().setVaiTro("Kh??ch h??ng");

				session.save(khachhang.getTaiKhoan2());
				session.save(khachhang);

				t.commit();
				model.addAttribute("message", "????ng k?? th??nh c??ng ! Vui l??ng ????ng nh???p !");

			}
		} catch (Exception e) {
			t.rollback();
			model.addAttribute("message", "????ng k?? th???t b???i !");
		} finally {
			session.close();
		}
		return "user/register";

	}

	@Autowired
	JavaMailSender mailer;

	@RequestMapping(value = "quenmatkhau", method = RequestMethod.GET)
	public String send(ModelMap model) {
		run(model);
		return "user/quenmk";
	}

	@RequestMapping(value = "quenmatkhau", method = RequestMethod.POST)
	public String send(ModelMap model, @RequestParam("email") String to) {
		run(model);
		boolean check = true;
		// ki??????m tra ????????????nh d??????ng email
		if (to.trim().isEmpty()) {
			check = false;
			model.addAttribute("LoiDinhDangEmail", "Email kh??ng ???????c ????? tr???ng !");
		} else if (!to.trim().matches("\\w+@\\w+(\\.\\w+)+")) {
			check = false;
			model.addAttribute("LoiDinhDangEmail", "Email kh??ng h???p l??? !");
		}
		KhachHang kh = new KhachHang();
		if (check) {
			try {
				Session s = factory.getCurrentSession();
				String hql = "FROM KhachHang where Email =:e";
				Query query = s.createQuery(hql);
				query.setParameter("e", to);
				List<KhachHang> list = query.list();
				if (list.isEmpty()) {
					model.addAttribute("message", "Email n??y ch??a ???????c ????ng k?? !");
					// return "redirect:/user/signin.htm";
				} else {
					kh = (KhachHang) query.list().get(0);
					String from = "vunganyen2000@gmail.com";
					String subject = "PET SHOP - Qu??n m???t kh???u";
					String body = "M???t kh???u c???a b???n l??:?? " + kh.getTaiKhoan2().getMatKhau();
					MimeMessage mail = mailer.createMimeMessage();
					// su dung lop tro giup
					MimeMessageHelper helper = new MimeMessageHelper(mail);
					helper.setFrom(from, from);
					helper.setTo(to);
					helper.setReplyTo(from, from);
					helper.setSubject(subject);
					helper.setText(body, true);

					// gui mai
					mailer.send(mail);
					model.addAttribute("message", "???? g???i email th??nh c??ng ! Vui l??ng ki???m tra h??m th?? !");
				}

			} catch (Exception e) {
				// TODO: handle exception
				model.addAttribute("message", "X???y ra l???i !");
			}
		}
		return "user/quenmk";
	}

	public void checkPQ(ModelMap model) {
		if (UserLogin.tenDangNhap.equals("none")) {
			
			model.addAttribute("dkdn", "block"); // ?????????ng nh??????p,k????,xu??????t
			model.addAttribute("tkdx", "none"); // ?????????ng xu??????t,t????i kho??????n
			model.addAttribute("user", "none"); // quy?????n KH
			model.addAttribute("admin", "none"); // quy?????n admin th????m,x????a,s??????a sp
			model.addAttribute("userId", "none"); // ten ???N
		} else {
			Session s = factory.getCurrentSession();
			String hql = "SELECT tk.VaiTro FROM TaiKhoan tk WHERE tk.TenDangNhap= :tdn";
			Query query = s.createQuery(hql);
			query.setParameter("tdn", UserLogin.tenDangNhap);
			String vaiTro = (String) query.list().get(0);
			System.out.println("vaiTro" + vaiTro);
			if (vaiTro.trim().equals("admin")) {
				// model.addAttribute("chedo","none");
				// model.addAttribute("nguoidung","none");
				model.addAttribute("dkdn", "none"); // ?????????ng nh??????p,k????,xu??????t
				model.addAttribute("tkdx", "block"); // ?????????ng xu??????t,t????i kho??????n
				model.addAttribute("user", "Admin " + UserLogin.ten);
				model.addAttribute("userId", UserLogin.tenDangNhap);
				model.addAttribute("admin", "block");
				System.out.println("admin zooo");
			}
			// n??????u l???? kh????ch h????ng
			else {
				// model.addAttribute("chedo","none");
				// model.addAttribute("nguoidung","block");
				model.addAttribute("dkdn", "none"); // ?????????ng nh??????p,k????,xu??????t
				model.addAttribute("tkdx", "block"); // ?????????ng xu??????t,t????i kho??????n
				model.addAttribute("user", "????n h??ng c???a " + UserLogin.ten);
				model.addAttribute("userId", UserLogin.tenDangNhap);
				model.addAttribute("admin", "none");
				System.out.println("kh????ch h????ng zooo");
			}

		}
	}

	//
	@RequestMapping("thongtinkh")
	public String showThongTinTK(ModelMap model) {
		run(model);
		Session session = factory.getCurrentSession();
		String hql = "FROM KhachHang kh where kh.taiKhoan2.TenDangNhap =:tdn";
		Query query = session.createQuery(hql);
		query.setParameter("tdn", UserLogin.tenDangNhap);
		KhachHang list = (KhachHang) query.list().get(0);
		model.addAttribute("account", list);
		model.addAttribute("tdn", UserLogin.tenDangNhap);
		ShowReport(model);
		Report.clear();
		return "user/thongtinKH";
	}

	@RequestMapping(value = "thongtinkh", params = "btnEdit")
	public String updateKH(HttpServletRequest request, ModelMap model, @ModelAttribute("account") KhachHang khachhang) {
		Session session = factory.getCurrentSession();
		run(model);
		try {
			// bi??????n ki??????m tra validate
			boolean check = true;

			// ki??????m tra ????????????nh d??????ng c??????a t????n kh????ng ???????????????c c???? s???????
			if (khachhang.getTenKH().trim().equals("")) {
				check = false;
				model.addAttribute("LoiDinhDangTen", "T??n kh??ch h??ng kh??ng ???????c ????? tr???ng !");
			} else if (!khachhang.getTenKH().trim().matches("\\D+")) {
				check = false;
				model.addAttribute("LoiDinhDangTen", "T??n kh??ch h??ng kh??ng h???p l??? !");
			}

			// ki??????m tra s??????? ?????i???????n tho??????i kh????ng c???? k???? t?????? ch?????? v???? ???????????? d????i l???? 10 s???????
			if (khachhang.getSdt().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i kh??ng ???????c ????? tr???ng !");
			} else if (!khachhang.getSdt().trim().matches("\\d{10}")) {
				check = false;
				model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i kh??ng h???p l???");
			} else {
				// ki??????m tra s?????? t???????n t??????i c??????a sdt trong c???? s?????? d?????? li????u
				try {
					String hql = "FROM KhachHang where Sdt =:s";
					Query query = session.createQuery(hql);
					query.setParameter("s", khachhang.getSdt());
					List<KhachHang> list = query.list();
					if (!list.isEmpty()) {
						System.out.print("tdn: " + list.get(0).getTaiKhoan2().getTenDangNhap());
						if (!list.get(0).getTaiKhoan2().getTenDangNhap().equals(UserLogin.tenDangNhap)) {
							check = false;
							model.addAttribute("LoiDinhDangSDT", "S??? ??i???n tho???i n??y ???? t???n t???i !");
						} else {
						}
					}
				} catch (Exception e) {
					// TODO: handle exception
					System.out.println("L???????i");
				}
			}

			// ki??????m tra ????????????a ch??????? kh????ng ???????????????c b????? tr???????ng
			if (khachhang.getDiaChi().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangDiaChi", "?????a ch??? kh??ng ???????c ????? tr???ng !");
			}

			// ki??????m tra ????????????nh d??????ng email : abc@gmail.com.vn
			if (khachhang.getEmail().trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangEmail", "Email kh??ng ???????c ????? tr???ng !");
			}
			// ki??????m tra ????????????nh d??????ng mail b??????ng regex
			else if (!khachhang.getEmail().trim().matches("\\w+@\\w+(\\.\\w+)+")) {
				check = false;
				model.addAttribute("LoiDinhDangEmail", "Email kh??ng h???p l??? !");
			} else {
				// ki??????m tra s?????? t???????n t??????i c??????a email trong c???? s?????? d?????? li????u
				try {
					String hql = "FROM KhachHang where Email =:email";
					Query query = session.createQuery(hql);
					query.setParameter("email", khachhang.getEmail());
					List<KhachHang> list = query.list();
					if (!list.isEmpty()) {
						if (!list.get(0).getTaiKhoan2().getTenDangNhap().equals(UserLogin.tenDangNhap)) {
							check = false;
							model.addAttribute("LoiDinhDangEmail", "?????a ch??? mail n??y ???? ???????c s??? d???ng !");
						} else {
						}
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}
			System.out.print("check: " + check);
			if (check) {
				Integer temp = this.updateKH(khachhang);
				if (temp != 0) {
					Report.tbThanhCong="block";
					Report.tbThatBai="none";
					return "redirect:/user/thongtinkh.htm";
				} else {
					Report.tbThanhCong="none";
					Report.tbThatBai="block";
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
			System.out.print("X??????y ra l???????i");
		}
		run(model);
		model.addAttribute("tdn", UserLogin.tenDangNhap);
		ShowReport(model);
		Report.clear();
		return "user/thongtinKH";
		// return "redirect:/user/my-account.htm";
	}

	public Integer updateKH(KhachHang kh) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM KhachHang kh where kh.taiKhoan2.TenDangNhap = :tdn";
			Query query = session.createQuery(hql);
			query.setParameter("tdn", UserLogin.tenDangNhap);
			KhachHang khachhang = (KhachHang) query.list().get(0);
			khachhang.setTenKH(kh.getTenKH());
			khachhang.setSdt(kh.getSdt());
			khachhang.setEmail(kh.getEmail());
			khachhang.setDiaChi(kh.getDiaChi());

			session.update(khachhang);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}

	//
	@RequestMapping(value = "pass", params = "passEdit")
	public String updatePass(HttpServletRequest request, ModelMap model, @ModelAttribute("account") KhachHang kh,
			@RequestParam("pass") String pass, @RequestParam("pass1") String newpass1,
			@RequestParam("pass2") String newpass2) {
		Session session = factory.getCurrentSession();
		run(model);
		try {
			boolean check = true;
			// ki??????m tra ????????????nh d??????ng m??????t kh??????u kh????ng ????t h????n 8 k???? t???? v???? m??????t kh??????u
			// kh????ng ch?????? kho??????ng tr??????ng
			if (pass.trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ???????c ????? tr???ng !");
			} else if (pass.trim().contains(" ")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng ch???a kho???ng tr???ng !");
			} else if (!pass.matches(".{8,}")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u kh??ng d?????i 8 k?? t??? !");
			} else {
				try {
					String hql = "SELECT tk.MatKhau FROM TaiKhoan tk where tk.TenDangNhap =:tdn";
					Query query = session.createQuery(hql);
					query.setParameter("tdn", UserLogin.tenDangNhap);
					String mk = (String) query.list().get(0);
					if (!mk.equals(pass)) {
						check = false;
						model.addAttribute("LoiDinhDangMatKhau", "M???t kh???u c?? kh??ng ????ng !");
					}
				} catch (Exception e) {
					// TODO: handle exception
				}
			}

			// ki??????m tra ????????????nh d??????ng m??????t kh??????u kh????ng ????t h????n 8 k???? t???? v???? m??????t kh??????u
			// kh????ng ch?????? kho??????ng tr??????ng
			if (newpass1.trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau1", "M???t kh???u kh??ng ???????c ????? tr???ng !");
			} else if (newpass1.trim().contains(" ")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau1", "M???t kh???u kh??ng ch???a kho???ng tr???ng !");
			} else if (!newpass1.trim().matches(".{8,}")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau1", "M???t kh???u kh??ng d?????i 8 k?? t??? !");
			}

			// ki??????m tra ????????????nh d??????ng m??????t kh??????u kh????ng ????t h????n 8 k???? t???? v???? m??????t kh??????u
			// kh????ng ch?????? kho??????ng tr??????ng
			if (newpass2.trim().isEmpty()) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau2", "M???t kh???u kh??ng ???????c ????? tr???ng !");
			} else if (newpass2.trim().contains(" ")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau2", "M???t kh???u kh??ng ch???a kho???ng tr???ng !");
			} else if (!newpass2.trim().matches(".{8,}")) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau2", "M???t kh???u kh??ng d?????i 8 k?? t??? !");
			}

			// so s????nh pass m???????i v???? pass m???????i l??????n 2
			if (!newpass1.equals(newpass2)) {
				check = false;
				model.addAttribute("LoiDinhDangMatKhau2", "M???t kh???u nh???p l???i kh??ng tr??ng kh???p !");
			}

			System.out.print("check: " + check);
			if (check) {
				Integer temp = this.updatePass(newpass1);
				if (temp != 0) {
					Report.tbThanhCong="block";
					Report.tbThatBai="none";
					return "redirect:/user/thongtinkh.htm";
				} else {
					Report.tbThanhCong="none";
					Report.tbThatBai="block";
				}
			}

		} catch (Exception e) {
			// TODO: handle exception
		}
		run(model);
		String hql = "FROM KhachHang kh where kh.taiKhoan2.TenDangNhap =:tdn";
		Query query = session.createQuery(hql);
		query.setParameter("tdn", UserLogin.tenDangNhap);
		KhachHang list = (KhachHang) query.list().get(0);
		model.addAttribute("account", list);
		model.addAttribute("tdn", UserLogin.tenDangNhap);
		ShowReport(model);
		Report.clear();

		return "user/thongtinKH";

	}

	public Integer updatePass(String pass) {
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM TaiKhoan where TenDangNhap = :tdn";
			Query query = session.createQuery(hql);
			query.setParameter("tdn", UserLogin.tenDangNhap);
			TaiKhoan taikhoan = (TaiKhoan) query.list().get(0);
			taikhoan.setMatKhau(pass);

			session.update(taikhoan);
			t.commit();
		} catch (Exception e) {
			t.rollback();
			return 0;
		} finally {
			session.close();
		}
		return 1;
	}

	//
	@RequestMapping("vohieuhoa")
	public String voHieuHoaTK(ModelMap model) {
		run(model);
		Session session = factory.openSession();
		Transaction t = session.beginTransaction();
		try {
			String hql = "FROM TaiKhoan tk where tk.TenDangNhap =:tdn";
			Query query = session.createQuery(hql);
			query.setParameter("tdn", UserLogin.tenDangNhap);
			TaiKhoan tk = (TaiKhoan) query.list().get(0);
			tk.setTrangThai(false);
			session.update(tk);
			t.commit();
		} catch (Exception e) {
			t.rollback();
		}

	 return "redirect:/user/dangxuat.htm";
	}
	
	@RequestMapping("contact")
	public String lienHe(ModelMap model) {
		run(model);

	 return "user/contact";
	}
	
	@RequestMapping("blog")
	public String xemTinTuc(ModelMap model) {
		run(model);
		Session session = factory.getCurrentSession();
		String hql = "FROM TinTuc ";
		Query query = session.createQuery(hql);
		List<TinTuc> list = query.list();
		model.addAttribute("listBlog", list);
	 return "user/blog";
	}
	
	@RequestMapping(value = "blog-detail/{maTT}", method = RequestMethod.GET)
	public String showSigle(ModelMap model, @PathVariable("maTT") Integer maTT) {
		run(model);
		Session session = factory.getCurrentSession();
		TinTuc tt = (TinTuc) session.get(TinTuc.class, maTT);
		model.addAttribute("tintuc", tt);
		return "user/blog-detail";
	}
	
}
