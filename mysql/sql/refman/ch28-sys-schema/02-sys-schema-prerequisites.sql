-- ============================================================
-- 第 28 章 MySQL 系统模式 · 先决条件

-- 文档：docs/refman/ch28-sys-schema/02-sys-schema-prerequisites.md
-- ============================================================

-- ---------- 原文示例 1 ----------
CALL sys.ps_setup_enable_instrument('wait');
CALL sys.ps_setup_enable_instrument('stage');
CALL sys.ps_setup_enable_instrument('statement');
CALL sys.ps_setup_enable_consumer('current');
CALL sys.ps_setup_enable_consumer('history_long');

-- ---------- 原文示例 2 ----------
CALL sys.ps_setup_reset_to_default(TRUE);

