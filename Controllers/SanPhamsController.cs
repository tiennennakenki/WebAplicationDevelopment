using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using DoAnWeb.Models;
namespace DoAnWeb.Controllers
{
    public class SanPhamsController : Controller
    {
        private NHOMWEBEntities db = new NHOMWEBEntities();

        
        public ActionResult RemoveFromCart(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            // Lấy sản phẩm từ database
            var product = db.SanPhams.Find(id);

            if (product == null)
            {
                return HttpNotFound();
            }

            // Lấy giỏ hàng từ session
            var cart = Session["cart"] as List<SanPham> ?? new List<SanPham>();

            // Xóa sản phẩm khỏi giỏ hàng
            cart.RemoveAll(p => p.MaSP == id);

            // Lưu giỏ hàng vào session
            Session["cart"] = cart;

            // Chuyển hướng đến trang giỏ hàng
            return RedirectToAction("Cart");
        }

        public ActionResult AddToCart(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            // Lấy sản phẩm từ database
            var product = db.SanPhams.FirstOrDefault(p => p.MaSP == id);

            if (product == null)
            {
                return HttpNotFound();
            }

            // Lấy giỏ hàng từ session
            var cart = Session["cart"] as List<SanPham> ?? new List<SanPham>();

            // Thêm sản phẩm vào giỏ hàng
            cart.Add(product);

            // Lưu giỏ hàng vào session
            Session["cart"] = cart;

            // Chuyển hướng đến trang giỏ hàng
            return RedirectToAction("Cart");
        }

        public ActionResult Cart()
        {
            if (Session["KhachHang"] != null)
            {
                // Lấy giỏ hàng từ session
                var cart = Session["cart"] as List<SanPham> ?? new List<SanPham>();

                return View(cart);
            }
            else
            {
                return RedirectToAction("Login", "KhachHangs");

            }
        }

        // GET: SanPhams

        public ActionResult Default()
        {
            var sanPhams = db.SanPhams.Include(s => s.LoaiSP).Include(s => s.NhaCungCap);
            return View(sanPhams.ToList());
        }
        public ActionResult Index(string spid)
        {
            if (spid == null)
            {
                var sanPhams = db.SanPhams.Include(p => p.LoaiSP);
                return View(sanPhams.ToList());
            }
            else
            {
                var sanPhams = db.SanPhams.Where(p => p.MaLSP == spid);
                return View(sanPhams.ToList());
            }
        }

        public ActionResult IndexAdmin()
        {
            if (Session["RoleUser"] != null)
            {
                var sanPhams = db.SanPhams.Include(p => p.LoaiSP);
                return View(sanPhams.ToList());
            }
            else
            {
                return RedirectToAction("Default", "SanPhams");

            }
        }
        public ActionResult TimKiem(string searchString)
        {
            var sanPhams = db.SanPhams.Where(s => s.TenSP.Contains(searchString)).ToList();
            return View(sanPhams);
        }
        // GET: SanPhams/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            return View(sanPham);
        }

        // GET: SanPhams/Create
        public ActionResult Create()
        {
            if (Session["RoleUser"] != null)
            {
                ViewBag.MaLSP = new SelectList(db.LoaiSPs, "MaLSP", "TenLSP");
                ViewBag.MaNCC = new SelectList(db.NhaCungCaps, "MaNCC", "TenNCC");
                return View();
            }
            else
            {
                return RedirectToAction("Default", "SanPhams");

            }
        }

        // POST: SanPhams/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaSP,TenSP,AnhSP,MoTaSP,MaLSP,MaNCC,DonGia")] SanPham sanPham)
        {
            if (ModelState.IsValid)
            {
                db.SanPhams.Add(sanPham);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaLSP = new SelectList(db.LoaiSPs, "MaLSP", "TenLSP", sanPham.MaLSP);
            ViewBag.MaNCC = new SelectList(db.NhaCungCaps, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // GET: SanPhams/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            // Kiểm tra quyền của người dùng
            if (Session["RoleUser"] == null)
            {
                return RedirectToAction("Default", "SanPhams");
            }

            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaLSP = new SelectList(db.LoaiSPs, "MaLSP", "TenLSP", sanPham.MaLSP);
            ViewBag.MaNCC = new SelectList(db.NhaCungCaps, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // POST: SanPhams/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaSP,TenSP,AnhSP,MoTaSP,MaLSP,MaNCC,DonGia")] SanPham sanPham)
        {
            if (ModelState.IsValid)
            {
                db.Entry(sanPham).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaLSP = new SelectList(db.LoaiSPs, "MaLSP", "TenLSP", sanPham.MaLSP);
            ViewBag.MaNCC = new SelectList(db.NhaCungCaps, "MaNCC", "TenNCC", sanPham.MaNCC);
            return View(sanPham);
        }

        // GET: SanPhams/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }

            if (Session["RoleUser"] == null)
            {
                return RedirectToAction("Default", "SanPhams");
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            return View(sanPham);
        }

        // POST: SanPhams/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            SanPham sanPham = db.SanPhams.Find(id);
            db.SanPhams.Remove(sanPham);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
