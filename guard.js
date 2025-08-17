// guard.js — exige login e checa permissão por página (user_pages)
(async () => {
  const cfg = window.APP_CONFIG || {};
  if (!window.supabase || !cfg.SUPABASE_URL) return;
  const { createClient } = window.supabase;
  const supabase = createClient(cfg.SUPABASE_URL, cfg.SUPABASE_ANON_KEY);

  const { data: { session } } = await supabase.auth.getSession();
  const qp = new URLSearchParams(location.search);
  const pageId = window.PAGE_ID || (document.body && document.body.dataset.pageId) || qp.get("page");

  if (!session || !session.user) {
    const backTo = encodeURIComponent(location.pathname + location.search);
    location.replace(`/login.html?next=${backTo}`);
    return;
  }
  if (!pageId) return;

  const { data: rows, error } = await supabase
    .from("user_pages").select("page_id, can_view")
    .eq("user_id", session.user.id)
    .eq("page_id", pageId)
    .eq("can_view", true).limit(1);

  if (error || !rows || rows.length === 0) {
    location.replace("/no-access.html");
  }
})();
