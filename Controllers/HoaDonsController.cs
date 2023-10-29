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
    public class HoaDonsController : Controller
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

        // GET: HoaDons
        public ActionResult Index()
        {
            var hoaDons = db.HoaDons.Include(h => h.KhachHang);
            return View(hoaDons.ToList());
        }

        public ActionResult CheckOut()
        {
            //if (id == null)
            //{
            //    return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            //}
            //KhachHang khachHang = db.KhachHangs.Find(id);
            //if (khachHang == null)
            //{
            //    return HttpNotFound();
            //}
            //return View(khachHang);
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CheckOut([Bind(Include = "MaKH,HoTen,DiaChi,SDT,GioiTinh,NgaySinh,Email")] KhachHang khachHang)
        {
            db.Entry(khachHang).State = EntityState.Modified;
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

        // GET: HoaDons/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            return View(hoaDon);
        }

        // GET: HoaDons/Create
        public ActionResult Create()
        {
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoTen");
            return View();
        }

        // POST: HoaDons/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SoHD,NgayLapHoaDon,TrangThai,MaKH")] HoaDon hoaDon)
        {
            if (ModelState.IsValid)
            {
                db.HoaDons.Add(hoaDon);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoTen", hoaDon.MaKH);
            return View(hoaDon);
        }

        // GET: HoaDons/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoTen", hoaDon.MaKH);
            return View(hoaDon);
        }

        // POST: HoaDons/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SoHD,NgayLapHoaDon,TrangThai,MaKH")] HoaDon hoaDon)
        {
            if (ModelState.IsValid)
            {
                db.Entry(hoaDon).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaKH = new SelectList(db.KhachHangs, "MaKH", "HoTen", hoaDon.MaKH);
            return View(hoaDon);
        }

        // GET: HoaDons/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            HoaDon hoaDon = db.HoaDons.Find(id);
            if (hoaDon == null)
            {
                return HttpNotFound();
            }
            return View(hoaDon);
        }

        // POST: HoaDons/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            HoaDon hoaDon = db.HoaDons.Find(id);
            db.HoaDons.Remove(hoaDon);
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
