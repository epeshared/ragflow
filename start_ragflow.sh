# 设置 HF_ENDPOINT 环境变量
export HF_ENDPOINT=https://hf-mirror.com
echo "Set HF_ENDPOINT to $HF_ENDPOINT"

# 设置 log_dir 为当前工作目录
log_dir=$PWD
echo "Log directory set to $log_dir"

# 检查并启动 xinference-local
if pgrep -f "xinference-local" > /dev/null; then
    echo "xinference-local is already running, skipping..."
else
    echo "Starting xinference-local on host 0.0.0.0 and port 9997"
    xinference-local --host 0.0.0.0 --port 9997 > $log_dir/xinference-local.log &
    echo "xinference-local started, logs are being written to $log_dir/xinference-local.log"
fi

# 启动 ollama (目前被注释掉了)
# echo "Starting ollama with llama3.1"
# ollama run llama3.1 &
# echo "ollama started"

# 检查并启动 entrypoint.sh
echo "Changing directory to /home/xtang/ragflow"
cd /home/xtang/ragflow
if pgrep -f "entrypoint.sh" > /dev/null; then
    echo "entrypoint.sh is already running, skipping..."
else
    echo "Running entrypoint.sh"
    ./entrypoint.sh > $log_dir/entrypoint.log &
    echo "entrypoint.sh executed, logs are being written to $log_dir/entrypoint.log"
fi

# 检查并启动 npm run dev
echo "Changing directory to /home/xtang/ragflow/web"
cd /home/xtang/ragflow/web
if pgrep -f "npm run dev" > /dev/null; then
    echo "npm run dev is already running, skipping..."
else
    echo "Running npm in development mode"
    npm run dev > $log_dir/npm.log &
    echo "npm run dev executed, logs are being written to $log_dir/npm.log"
fi

# 返回到 log_dir 目录
echo "Changing back to log directory $log_dir"
cd $log_dir
echo "Script execution completed"
